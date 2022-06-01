using Npgsql;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

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
                con = new NpgsqlConnection("Host=localhost;database=Plenna;user id=postgres;password=mauri245");
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
                
                if(rd.Read())
                {
                    MessageBox.Show(contra);
 
                    if (contra == rd.GetString(0).GetHashCode().ToString())
                    {
                        res = 1;
                        //if (correo == "meredith@plenna.mx")
                        //{
                        //    res = 2;
                        //}
                    }
                    con.Close();
                    
                }
                rd.Close();
                
            }
            catch (Exception msg)
            {
                MessageBox.Show("No se logro" + msg);
            }

            return res;
        }

       
    }
}

