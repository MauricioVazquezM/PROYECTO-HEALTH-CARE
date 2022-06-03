using Npgsql;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace ProyectoHealthCare.Clases
{
    class CConexion
    {
        NpgsqlConnection conex = new NpgsqlConnection();

        static String servidor = "localhost";
        static String bd = "Plenna";
        static String usuario = "postgres";
        static String password = "mauri245";
        static String puerto = "5432";


        String cadenaConexion = "server=" + servidor + ";" + "port=" + puerto + ";" + "user id=" + usuario + ";" + "password=" + password + ";" + "database=" + bd + ";";
        public static NpgsqlConnection establecerConexion()
        {

            NpgsqlConnection con;
            try
            {
                con = new NpgsqlConnection("Host=localhost;database=plenna;user id=postgres;password=mauri245");
                con.Open();
            }
            catch (Exception)
            {
                con = null;
            }
            return con;

        }

        public static int verificacionUsuario(String correo, String contra)
        {
            int res = 0;
            try
            {
                NpgsqlConnection con = CConexion.establecerConexion();
                NpgsqlCommand cmd = new NpgsqlCommand(String.Format("select m.contra from medico m where m.correo='{0}'", correo), con);
                NpgsqlDataReader rd = cmd.ExecuteReader();

                if (rd.Read())
                {
                    if (contra == rd.GetString(0))
                    {
                        res = 1;
                        if (correo == "meredith@plenna.mx")
                        {
                            res = 2;
                        }
                    }

                    rd.Close();
                }

                con.Close();
            }
            catch (Exception msg)
            {
                MessageBox.Show("No se logro" + msg);
            }

            return res;
        }

        public static void llenarComboPacientes(ComboBox dd)
        {
            int idm = 0;
            String correo = Application.Current.Properties["correo"].ToString();
            try
            {
                NpgsqlConnection con = establecerConexion();
                NpgsqlCommand cmd = new NpgsqlCommand(String.Format("select m.id_medico from medico m where correo = '{0}'", correo), con);
                NpgsqlCommand cmd1;
                NpgsqlDataReader rd = cmd.ExecuteReader();
                NpgsqlDataReader rd1;

                while (rd.Read())
                {
                    idm = rd.GetInt32(0);

                }

                rd.Close();

                cmd1 = new NpgsqlCommand(String.Format("select p.nombre" +
                    " from paciente p inner join paciente_medico pm using (id_paciente) where pm.id_medico = {0}", idm), con);
                rd1 = cmd1.ExecuteReader();

                while (rd1.Read())
                {
                    dd.Items.Add(rd.GetString(0));
                }
                rd1.Close();
                dd.SelectedIndex = 0;
                con.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("Error al llenar el comboBox");
            }
        }

        public static void DatosContactos(DataGrid gv)
        {
            String pa = Application.Current.Properties["paciente"].ToString();
            try
            {
                NpgsqlConnection con = establecerConexion();
                NpgsqlCommand cmd = new NpgsqlCommand(String.Format("Select * from sueno inner join paciente p using (id_paciente) where p.nombre = '{0}'", pa), con);
                NpgsqlDataReader rd = cmd.ExecuteReader();
                gv.ItemsSource = rd;
                gv.DataBind();
                rd.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("Error al cargar la informacion");
            }

        }
    }
}

