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
    /// Interaction logic for MedicoGeneral.xaml
    /// </summary>
    public partial class MedicoGeneral : Window
    {
        public MedicoGeneral()
        {
            InitializeComponent();
            cj.Navigate(new Uri("http://localhost:3000")); 
            Clases.CConexion.llenarComboPacientesGen(pacientes);

            String correo = Application.Current.Properties["correo"].ToString();
            NpgsqlConnection con = Clases.CConexion.establecerConexion();

            NpgsqlCommand cmd = new NpgsqlCommand(String.Format("select m.nombre || ' ' || m.apellido FROM medico m where m.correo ='{0}'", correo), con);
            NpgsqlDataReader rd = cmd.ExecuteReader();

            while (rd.Read())
                {
                nombre.Content = rd.GetString(0);
                 }
             rd.Close();
             con.Close();
            
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
            Configuracion MiVentana = new Configuracion();
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }

        private void acceso_Click(object sender, RoutedEventArgs e)
        {
            Permisos MiVentana = new Permisos();
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            String paciente = pacientes.Text;
            Application.Current.Properties["paciente"] = paciente;
            InfoPac MiVentana = new InfoPac();
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }

        private void Button_Click_3(object sender, RoutedEventArgs e)
        {
            String paciente = pacientes.Text;
            Application.Current.Properties["paciente"] = paciente;
            Application.Current.Properties["especialidad"] = especialidad.Content;
            Application.Current.Properties["medico"] = nombre.Content;
            Updates MiVentana = new Updates();
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }

        private void nuevas_notas_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Properties["paciente"] = pacientes.Text;
            Application.Current.Properties["especialidad"] = especialidad.Content;
            Application.Current.Properties["medico"] = nombre.Content;

            Insights MiVentana = new Insights();
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }

        private void notas_Click(object sender, RoutedEventArgs e)
        {
            String paciente = pacientes.Text;
            Application.Current.Properties["paciente"] = paciente;
            Notas MiVentana = new Notas();
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }

        private void notasGenerales_Click(object sender, RoutedEventArgs e)
        {
            String paciente = pacientes.Text;
            Application.Current.Properties["paciente"] = paciente;
            NotasGenerales MiVentana = new NotasGenerales();
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }
    }
}
