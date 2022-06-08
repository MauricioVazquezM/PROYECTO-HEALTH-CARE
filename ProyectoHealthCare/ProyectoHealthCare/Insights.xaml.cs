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
    /// Interaction logic for Insights.xaml
    /// </summary>
    public partial class Insights : Window
    {
        public Insights()
        {
            InitializeComponent();
            Clases.CConexion.llenarComboPacientes(pacientes);
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            Application.Current.Properties.Remove("paciente");
            Application.Current.Properties.Remove("especialidad");
            Application.Current.Properties.Remove("medico");

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
            MainWindow MiVentana = new MainWindow();
            Application.Current.Properties.Remove("correo");
            Application.Current.Properties.Remove("paciente");
            Application.Current.Properties.Remove("medico");
            Application.Current.Properties.Remove("especialidad");
            MiVentana.Owner = this;
            MiVentana.Show();
            this.Hide();
        }

        private void realizar_Click(object sender, RoutedEventArgs e)
        {
            String insight = diagnostico.Text;
            String cuando = fecha.Text;
            String medico = Application.Current.Properties["medico"].ToString();
            String paciente = pacientes.Text;
            String esp = Application.Current.Properties["especialidad"].ToString();
            String nombre = "";
            String apellido = "";


            int idp = 0;
            int idm = 0;

            NpgsqlConnection con = Clases.CConexion.establecerConexion();
            NpgsqlCommand cmd = new NpgsqlCommand(String.Format("select m.nombre,m.apellido FROM medico m where " +
                "(m.nombre || ' ' || m.apellido) ='{0}'", medico), con);
            NpgsqlDataReader rd = cmd.ExecuteReader();

            while (rd.Read())
            {
                nombre = rd.GetString(0);
                apellido = rd.GetString(1);
            }

            rd.Close();
            con.Close();

            NpgsqlConnection con1 = Clases.CConexion.establecerConexion();
            NpgsqlCommand cmd1 = new NpgsqlCommand(String.Format("select m.id_medico FROM medico m where m.nombre = '{0}' and apellido = '{1}'", nombre, apellido), con1);
            NpgsqlDataReader rd1 = cmd1.ExecuteReader();

            while (rd1.Read())
            {
                idm = rd1.GetInt16(0);
            }

            rd1.Close();

            NpgsqlCommand cmd2 = new NpgsqlCommand(String.Format("select p.id_paciente FROM paciente p where p.nombre = '{0}'", paciente), con1);
            NpgsqlDataReader rd2 = cmd2.ExecuteReader();

            while (rd2.Read())
            {
                idp = rd2.GetInt16(0);
            }
            rd2.Close();
            con1.Close();

            try
            {
                if (esp == "Sexologia")
                {
                    NpgsqlConnection conex = Clases.CConexion.establecerConexion();
                    NpgsqlCommand cmmd = new NpgsqlCommand(String.Format("insert into notas_sexualidad (id_paciente,id_medico,hecha_por,insight,vigente,fecha) values ({0},{1},'{2}','{3}',true,'{4}')", idp,idm,medico,insight,cuando), conex);
                    cmmd.ExecuteNonQuery();
                    conex.Close();
                }
                else
                {
                    NpgsqlConnection conex = Clases.CConexion.establecerConexion();
                    NpgsqlCommand cmmd = new NpgsqlCommand(String.Format("insert into notas_{0} (id_paciente,id_medico,hecha_por,insight,vigente,fecha) values ({1},{2},'{3}','{4}',true,'{5}')",esp, idp, idm, medico, insight,cuando), conex);
                    cmmd.ExecuteNonQuery();
                    conex.Close();
                }

                MessageBox.Show("Nota de consulta realizada con éxito");
            }
            catch (Exception)
            {
                MessageBox.Show("La fecha que indica no está en el formato correcto");
            }

        }
    }
}
