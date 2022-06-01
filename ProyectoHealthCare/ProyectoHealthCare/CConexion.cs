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
                con = new NpgsqlConnection("Host=localhost;database=mil;user id=postgres;password=mauri245");
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
                        if(correo == "meredith@plenna.mx")
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
            try
            {
                NpgsqlConnection con = establecerConexion();
                NpgsqlCommand cmd = new NpgsqlCommand("SELECT p.nombre FROM paciente p", con);
                NpgsqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    dd.Items.Add(rd.GetString(0));
                }
                dd.SelectedIndex = 0; 
                rd.Close();
                con.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("Error al llenar el comboBox");
            }
        }

    }
}

