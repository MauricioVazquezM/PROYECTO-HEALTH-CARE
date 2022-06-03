using Npgsql;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace ProyectoHealthCare
{
    /// <summary>
    /// Interaction logic for InfoPac.xaml
    /// </summary>
    public partial class InfoPac : Window
    {
        public InfoPac()
        {
            InitializeComponent();
            String aux = Application.Current.Properties["paciente"].ToString();
            nombre.Content = aux;
            especialidad.Items.Add("Nutricion");
            especialidad.Items.Add("Psicologia");
            especialidad.Items.Add("Ginecologia");
            especialidad.Items.Add("Sexologia");
            especialidad.Items.Add("Sueno");
            especialidad.SelectedIndex = 0;

             try
            {
                NpgsqlConnection con = Clases.CConexion.establecerConexion();
                NpgsqlConnection conex = Clases.CConexion.establecerConexion();
                NpgsqlCommand cmd1 = new NpgsqlCommand(String.Format("Select * from paciente p where p.nombre = '{0}'",aux), con);
                NpgsqlCommand cmd2 = new NpgsqlCommand(String.Format("select e.nombre from paciente p inner join paciente_enfermedad using (id_paciente) inner join enfermedad e using (id_enfermedad) where p.nombre = '{0}'",aux),conex);
                NpgsqlDataReader rd1 = cmd1.ExecuteReader();
                NpgsqlDataReader rd2 = cmd2.ExecuteReader();
                general.ItemsSource = rd1;
                enfermedades.ItemsSource = rd2; 
            }
            catch (Exception)
            {
                MessageBox.Show("Error al cargar la informacion");
            }


        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            String esp = especialidad.Text;
            String pac = Application.Current.Properties["paciente"].ToString();
            int idp = 0;

            try
            {
                NpgsqlConnection con = Clases.CConexion.establecerConexion();
                NpgsqlCommand cmd = new NpgsqlCommand(String.Format("select id_paciente from paciente where nombre = '{0}'",pac), con);
                NpgsqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    idp = rd.GetInt16(0);
                }

                if (esp == "Nutricion" || esp == "Ginecologia")
                {
                    NpgsqlConnection con1 = Clases.CConexion.establecerConexion();
                    NpgsqlCommand cmd2;
                    NpgsqlDataReader rd2;

                    if (esp == "Ginecologia")
                    {
                        cmd2 = new NpgsqlCommand(String.Format("select a.nombre from ginecologia g inner join ginecologia_anticonceptivos " +
                            "ga using(id_ginecologia) inner join anticonceptivos a using(id_anticonceptivos) where id_paciente = {0}", idp), con1);
                        rd2 = cmd2.ExecuteReader();
                        apoyo.ItemsSource = rd2;
                        extra.Content = "anticonceptivos";
                    }
                    else
                    {
                        cmd2 = new NpgsqlCommand(String.Format("select e.nombre from nutricion n inner join nutricion_ejercicio ne using (id_nutricion) " +
                            "inner join ejercicio e using (id_ejercicio) where n.id_paciente = {0}", idp), con1);
                        rd2 = cmd2.ExecuteReader();
                        apoyo.ItemsSource = rd2;
                        extra.Content = "ejercicio";
                    }

                }
                else
                {
                    extra.Content = "";
                    apoyo.ItemsSource= "";
                }


            }

            catch (Exception)
            {
                MessageBox.Show("Error");
            }
            Clases.CConexion.DatosPacientes(grid,esp,idp);
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            MainWindow MiVentana = new MainWindow();
            Application.Current.Properties.Remove("correo");
            Application.Current.Properties.Remove("paciente");
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            Application.Current.Properties.Remove("paciente");
            String correo = Application.Current.Properties["correo"].ToString();

            if (correo == "meredith@plenna.mx")
            {
                MedicoGeneral ventana = new MedicoGeneral();
                ventana.Owner = this;
                ventana.Show();
                this.Hide();
            }
            else
            {
                MedicoCualquiera MiVentana = new MedicoCualquiera();
                MiVentana.Owner = this;
                MiVentana.Show();
                this.Hide();
            }
        }
    }
}
