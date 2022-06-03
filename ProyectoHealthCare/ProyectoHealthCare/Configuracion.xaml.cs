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
    /// Interaction logic for Configuracion.xaml
    /// </summary>
    public partial class Configuracion : Window
    {
        public Configuracion()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
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

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            String correo = Application.Current.Properties["correo"].ToString();
            try
            {
                NpgsqlConnection con = Clases.CConexion.establecerConexion();
                NpgsqlCommand cmd = new NpgsqlCommand(String.Format("select m.contra from medico m where m.correo='{0}'", correo), con);
                NpgsqlDataReader rd = cmd.ExecuteReader();
 

                if (rd.Read())
                {
                    String actuall = rd.GetString(0);
                    String cambio = nueva.Password.ToString();
                    if (actual.Password.ToString() == rd.GetString(0) && nueva.Password.ToString() == confirmacion.Password.ToString())
                    {
                        rd.Close();
                        NpgsqlCommand cmd1 = new NpgsqlCommand(String.Format("UPDATE medico SET contra = '{0}' WHERE contra = '{1}'",cambio,actuall), con);
                        cmd1.ExecuteNonQuery();
                        MessageBox.Show("Su contraseña ha sido cambiada");
                    }

                    rd.Close();

                }

                con.Close();
            }
            catch (Exception msg)
            {
                MessageBox.Show("No se logro" + msg);
            }
        }
    }
}
