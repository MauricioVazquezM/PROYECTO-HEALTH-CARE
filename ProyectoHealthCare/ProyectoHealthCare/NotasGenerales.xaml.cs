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
    /// Interaction logic for NotasGenerales.xaml
    /// </summary>
    public partial class NotasGenerales : Window
    {
        public NotasGenerales()
        {
            InitializeComponent();
            Clases.CConexion.llenarComboPacientesGen(pacientes);
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

        private void realizar_Click(object sender, RoutedEventArgs e)
        {
            String insight = diagnostico.Text;
            String cuando = fecha.Text;
            String paciente = pacientes.Text;


            int idp = 0;


            NpgsqlConnection con = Clases.CConexion.establecerConexion();
            NpgsqlCommand cmd = new NpgsqlCommand(String.Format("select p.id_paciente FROM paciente p where p.nombre = '{0}'", paciente), con);
            NpgsqlDataReader rd = cmd.ExecuteReader();

            while (rd.Read())
            {
                idp = rd.GetInt16(0);
            }
            rd.Close();
            con.Close();

            try
            {
                
                    NpgsqlConnection conex = Clases.CConexion.establecerConexion();
                    NpgsqlCommand cmmd = new NpgsqlCommand(String.Format("insert into notas_generales (id_paciente,id_medico,hecha_por,insight,vigente,fecha) values ({0},1,'Meredith Grey','{1}',true,'{2}')", idp, insight, cuando), conex);
                    cmmd.ExecuteNonQuery();
                    conex.Close();
                    MessageBox.Show("Nota de consulta realizada con éxito");
            }
            catch (Exception)
            {
                MessageBox.Show("La fecha que indica no está en el formato correcto");
            }

        }
    }
}
