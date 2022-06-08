using Npgsql;
using System;
using System.Collections.Generic;
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
    /// Interaction logic for Notas.xaml
    /// </summary>
    public partial class Notas : Window
    {
        public Notas()
        {
            InitializeComponent();
            String aux = Application.Current.Properties["paciente"].ToString();
            nombre.Content = aux;
            int id = 0;
            NpgsqlConnection c = Clases.CConexion.establecerConexion();
            NpgsqlCommand cm = new NpgsqlCommand(String.Format("Select p.id_paciente from paciente p where p.nombre = '{0}'", aux), c);
            NpgsqlDataReader rd = cm.ExecuteReader();

            while (rd.Read())
            {
                id = rd.GetInt16(0);
            }
            rd.Close();
            c.Close();


            try
            {
                NpgsqlConnection con = Clases.CConexion.establecerConexion();
                NpgsqlConnection con1 = Clases.CConexion.establecerConexion();
                NpgsqlConnection con2 = Clases.CConexion.establecerConexion();
                NpgsqlConnection con3 = Clases.CConexion.establecerConexion();
                NpgsqlConnection con4 = Clases.CConexion.establecerConexion();
                NpgsqlConnection con5 = Clases.CConexion.establecerConexion();

                NpgsqlCommand cmd1 = new NpgsqlCommand(String.Format("Select * from notas_generales n where n.id_paciente = {0}", id), con);
                NpgsqlCommand cmd2 = new NpgsqlCommand(String.Format("Select * from notas_nutricion n where n.id_paciente = {0}", id), con1);
                NpgsqlCommand cmd3 = new NpgsqlCommand(String.Format("Select * from notas_ginecologia n where n.id_paciente = {0}", id), con2);
                NpgsqlCommand cmd4 = new NpgsqlCommand(String.Format("Select * from notas_psicologia n where n.id_paciente = {0}", id), con3);
                NpgsqlCommand cmd5 = new NpgsqlCommand(String.Format("Select * from notas_sexualidad n where n.id_paciente = {0}", id), con4);
                NpgsqlCommand cmd6 = new NpgsqlCommand(String.Format("Select * from notas_sueno n where n.id_paciente = {0}", id), con5);


                NpgsqlDataReader rd1 = cmd1.ExecuteReader();
                NpgsqlDataReader rd2 = cmd2.ExecuteReader();
                NpgsqlDataReader rd3 = cmd3.ExecuteReader();
                NpgsqlDataReader rd4 = cmd4.ExecuteReader();
                NpgsqlDataReader rd5 = cmd5.ExecuteReader();
                NpgsqlDataReader rd6 = cmd6.ExecuteReader();

                gridGeneral.ItemsSource = rd1;
                gridNutricion.ItemsSource = rd2;
                gridGinecologia.ItemsSource = rd3;
                gridPsicologia.ItemsSource = rd4;
                gridSexologia.ItemsSource = rd5;
                gridSueno.ItemsSource = rd6;

            }
            catch (Exception)
            {
                MessageBox.Show("Error al cargar la informacion");
            }




        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            MainWindow MiVentana = new MainWindow();
            Application.Current.Properties.Remove("correo");
            Application.Current.Properties.Remove("paciente");
            Application.Current.Properties.Remove("medico");
            Application.Current.Properties.Remove("especialidad");
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
