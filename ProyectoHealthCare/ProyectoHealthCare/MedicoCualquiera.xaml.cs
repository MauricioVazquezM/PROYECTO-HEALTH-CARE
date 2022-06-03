using Npgsql;
using ProyectoHealthCare.Clases;
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
    /// Interaction logic for MedicoCualquiera.xaml
    /// </summary>
    public partial class MedicoCualquiera : Window
    {
        public MedicoCualquiera()
        {
            InitializeComponent();
            CConexion.llenarComboPacientes(pacientes);

            String correo = Application.Current.Properties["correo"].ToString();

            NpgsqlConnection con = Clases.CConexion.establecerConexion();
            NpgsqlCommand cmd = new NpgsqlCommand(String.Format("select m.nombre || ' ' || m.apellido FROM medico m where m.correo ='{0}'", correo), con);
            NpgsqlCommand cmd1 = new NpgsqlCommand(String.Format("select m.id_medico from medico m where m.correo = '{0}'",correo), con);
            NpgsqlCommand cmd2;
            NpgsqlCommand cmd3;
            NpgsqlDataReader rd = cmd.ExecuteReader();
            NpgsqlDataReader rd1; 
            NpgsqlDataReader rd2; 
            NpgsqlDataReader rd3;
            int id = 0;
            int ide = 0;
            while (rd.Read())
            {
                nombre.Content = rd.GetString(0);
            }
            rd.Close();

            rd1 = cmd1.ExecuteReader();
            while (rd1.Read())
            {
                id = rd1.GetInt16(0);
            }
            rd1.Close();

            cmd2 = new NpgsqlCommand(String.Format("select me.id_especialidad from medico_especialidad me where id_medico = {0}",id), con);
            rd2 = cmd2.ExecuteReader();

            while (rd2.Read())
            {
                ide = rd2.GetInt16(0);
            }
            rd2.Close();

            cmd3 = new NpgsqlCommand(String.Format("select e.nombre from especialidad e where id_especialidad = {0}", ide), con);
            rd3 = cmd3.ExecuteReader();

            while (rd3.Read())
            {
                especialidad.Content = rd3.GetString(0);
            }
            rd3.Close();
            con.Close();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            String paciente = pacientes.Text;
            Application.Current.Properties["paciente"] = paciente;
            Updates MiVentana = new Updates();
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            MainWindow MiVentana = new MainWindow();
            Application.Current.Properties.Remove("correo");
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }

        private void verInfo_Click(object sender, RoutedEventArgs e)
        {
            String paciente = pacientes.Text;
            Application.Current.Properties["paciente"] = paciente;
            InfoPac MiVentana = new InfoPac();
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }
    }
}
