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
    /// Interaction logic for Updates.xaml
    /// </summary>
    public partial class Updates : Window
    {
        public Updates()
        {
            InitializeComponent();
            String pac = Application.Current.Properties["paciente"].ToString();
            paciente.Content = pac;
            String medico = Application.Current.Properties["medico"].ToString();
            String especialidad = Application.Current.Properties["especialidad"].ToString();

            Clases.CConexion.gridDeUpdates(info, especialidad, medico, pac);


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
            Application.Current.Properties.Remove("medico");
            Application.Current.Properties.Remove("especialidad");
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

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            String esp = Application.Current.Properties["especialidad"].ToString();
            String nuevo = diagnostico.Text;
            String id = registro.Text;
            try
            {

                NpgsqlConnection con = Clases.CConexion.establecerConexion();
                NpgsqlCommand cmd1; 

                if (esp == "Sexologia")
                {
                    cmd1 = new NpgsqlCommand(String.Format("update notas_sexualidad set insight = '{0}' where id_notas_sexualidad = {1}", nuevo, id), con);
                    cmd1.ExecuteNonQuery();
                }
                else
                {
                    cmd1 = new NpgsqlCommand(String.Format("update notas_{0} set insight = '{1}' where id_notas_{0} = {2}",esp, nuevo, id), con);
                    cmd1.ExecuteNonQuery();

                }

                con.Close();
                MessageBox.Show("El diagnóstico ha sido actualizado");

            }
            

            catch (Exception msg)
            {
                MessageBox.Show("No se logro" + msg);
            }
        }

        private void vigencia_Click(object sender, RoutedEventArgs e)
        {
            String id = registro.Text;
            String esp = Application.Current.Properties["especialidad"].ToString();

            try
            {

                NpgsqlConnection con = Clases.CConexion.establecerConexion();
                NpgsqlCommand cmd1;

                if (esp == "Sexologia")
                {
                    cmd1 = new NpgsqlCommand(String.Format("update notas_sexualidad set vigente = false where id_notas_sexualidad = {0}", id), con);
                    cmd1.ExecuteNonQuery();
                }
                else
                {
                    cmd1 = new NpgsqlCommand(String.Format("update notas_{0} set vigente = false where id_notas_{0} = {1}", esp, id), con);
                    cmd1.ExecuteNonQuery();

                }

                con.Close();
                MessageBox.Show("El diagnóstico ha sido actualizado");

            }


            catch (Exception msg)
            {
                MessageBox.Show("No se logro" + msg);
            }
        }
    }
}
