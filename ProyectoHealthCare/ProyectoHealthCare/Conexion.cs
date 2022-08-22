//using System;
//using System.Collections.Generic;
//using System.Data.SqlClient;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;
//using System.Windows;
//using System.Windows.Controls;
//using Npgsql;

//namespace ProyectoHealthCare.ProyectoHealthCare 
//{
//    class Conexion
//    {
//        NpgsqlConnection conn = new NpgsqlConnection("Host = localhost; Username=______;Password=_____;Database=PLENNA");
//        public NpgsqlConnection agregarConexion(){
//            try{
//                conn.ConnectionString=
                
//            }
//            catch
//            {

//            }

    
//        }

//        public static void llenarComboPlatillos(ComboBox cb)
//        {
//            SqlConnection con;
//            SqlCommand cmm;
//            SqlDataReader dr;
//            try
//            {
//                con = Conexion.agregarConexion();
//                cmm = new SqlCommand("select nombre from platillos", con);
//                dr = cmm.ExecuteReader();
//                while (dr.Read())
//                {
//                    cb.Items.Add(dr.GetString(0));
//                }
//                cb.SelectedIndex = 0;
//                dr.Close();
//                con.Close();


//            }
//            catch
//            {
//                MessageBox.Show("ERROR en llenar el combo Platillos");
//            }
//        }

//        public static String generaReporte(DataGrid dgReporte, String resp)
//        {
//            String res = "";
//            String query1;
//            SqlCommand cmm1;
//            SqlDataReader dr;
//            try
//            {
//                SqlConnection con = Conexion.agregarConexion();


//                query1 = String.Format("select * from comentarios where recomendacion='{0}'", resp);
//                cmm1 = new SqlCommand(query1, con);
//                dr = cmm1.ExecuteReader();
//                dgReporte.ItemsSource = dr;
//                res = "reporte generado";


//            }
//            catch (Exception e)
//            {
//                MessageBox.Show("no se pudo generar reporte" + e);
//            }
//            return res;
//        }
//    }
//}
