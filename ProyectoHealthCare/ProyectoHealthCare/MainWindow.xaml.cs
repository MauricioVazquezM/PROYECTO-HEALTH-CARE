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
using System.Windows.Navigation;
using System.Windows.Shapes;
using Npgsql;
using ProyectoHealthCare.Clases;

namespace ProyectoHealthCare
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            String correoInsert = correoelectronico.Text;
            String contraInsert = contra.GetHashCode().ToString();

            int res = 0;
            res = Clases.CConexion.verificacionUsuario(correoInsert, contraInsert);
            if (res == 1)
            {
                MedicoGeneral MiVentana = new MedicoGeneral();
                MiVentana.Owner = this;
                MiVentana.Show();
                this.Hide();
            }
            else
            {
                MedicoCualquiera MiVentana = new MedicoCualquiera();
                MiVentana.Owner = this;
                MiVentana.Show();
                this.Hide();
                //if (res == 1)
                //{
                //    MedicoCualquiera MiVentana = new MedicoCualquiera();
                //    MiVentana.Owner = this;
                //    MiVentana.Show();
                //    this.Hide();
                //}
                //else
                //{
                //    MessageBox.Show("Su correo o contrasena es invalido");
                //}

            }


            //try
            //{
            //    // PostgeSQL-style connection string
            //    string connstring = "server=postgres;port=5432;user id=postgres;password=mauri245;database=postgres;";
            //    // Making connection with Npgsql provider
            //    NpgsqlConnection conn = new NpgsqlConnection(connstring);
            //    conn.Open();
            //    // quite complex sql statement
            //    String sql = "1"; //String.Format("SELECT m.medico_general FROM 'Plenna'.medico m where m.correo{0}", correoelectronico.Text);

            //    if (res == 1)
            //    {
            //        if (sql == "1")
            //        {
            //            MedicoCualquiera MiVentana = new MedicoCualquiera();
            //            MiVentana.Owner = this;
            //            MiVentana.Show();
            //            this.Hide();
            //        }
            //        else
            //        {
            //            MedicoGeneral MiVentana = new MedicoGeneral();
            //            MiVentana.Owner = this;
            //            MiVentana.Show();
            //            this.Hide();
            //        }
            //    }
            //    else
            //    {
            //        MessageBox.Show("El correo o la contrasena es invalido");
            //    }
            //    conn.Close();
            //}
            //catch (Exception ex)
            //{
            //    MessageBox.Show("Error: " + ex);
            //}

        }
    }
}
