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

        static String servidor = "_________________";
        static String bd = "Plennadb";
        static String usuario = "_______";
        static String password = "________";
        static String puerto = "________";


        String cadenaConexion = "server=" + servidor + ";" + "port=" + puerto + ";" + "user id=" + usuario + ";" + "password=" + password + ";" + "database=" + bd + ";";
        public static NpgsqlConnection establecerConexion()
        {

            NpgsqlConnection con;
            try
            {
                con = new NpgsqlConnection("Host=_________;database=Plennadb;user id=________;password=_________");
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


        public static void llenarComboPacientesGen(ComboBox dd)
        {
            try
            {
                NpgsqlConnection con = establecerConexion();
                NpgsqlCommand cmd = new NpgsqlCommand("select p.nombre from paciente p", con);
                NpgsqlDataReader rd = cmd.ExecuteReader();
            
                while (rd.Read())
                {
                    dd.Items.Add(rd.GetString(0));
                }
                rd.Close();
                dd.SelectedIndex = 0;
                con.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("Error al llenar el comboBox");
            }
        }

        public static void llenarComboDoctoresGen(ComboBox dd)
        {
            try
            {
                NpgsqlConnection con = establecerConexion();
                NpgsqlCommand cmd = new NpgsqlCommand("select m.nombre || ' ' || m.apellido FROM medico m", con);
                NpgsqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    dd.Items.Add(rd.GetString(0));
                }
                rd.Close();
                dd.SelectedIndex = 0;
                con.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("Error al llenar el comboBox");
            }
        }

        public static void DatosPacientes(DataGrid gv, String es, int idp)
        {

            try
            {
                NpgsqlConnection con = establecerConexion();
                NpgsqlCommand cmd1 = new NpgsqlCommand(String.Format("Select * from {0} where id_paciente = {1}",es,idp), con);
                NpgsqlDataReader rd1 = cmd1.ExecuteReader();
                gv.ItemsSource = rd1;


            }
            catch (Exception)
            {
                MessageBox.Show("Error al cargar la informacion");
            }

        }

        public static void gridDeUpdates(DataGrid gv, String es, String medico, String paciente)
        {
            int idm = 0;
            int idp = 0;
            String nombre = "";
            String apellido = "";

            NpgsqlConnection con = CConexion.establecerConexion();
            NpgsqlCommand cmd = new NpgsqlCommand(String.Format("select m.nombre,m.apellido FROM medico m where " +
                "(m.nombre || ' ' || m.apellido) ='{0}'", medico), con);
            NpgsqlDataReader rd = cmd.ExecuteReader();

            while (rd.Read())
            {
                nombre = rd.GetString(0);
                apellido = rd.GetString(1);
            }

            rd.Close();

            NpgsqlCommand cmd1 = new NpgsqlCommand(String.Format("select m.id_medico FROM medico m where m.nombre = '{0}' and apellido = '{1}'", nombre, apellido), con);
            NpgsqlDataReader rd1 = cmd1.ExecuteReader();

            while (rd1.Read())
            {
                idm = rd1.GetInt16(0);
            }

            rd1.Close();

            NpgsqlCommand cmd2 = new NpgsqlCommand(String.Format("select p.id_paciente FROM paciente p where p.nombre = '{0}'", paciente), con);
            NpgsqlDataReader rd2 = cmd2.ExecuteReader();

            while (rd2.Read())
            {
                idp = rd2.GetInt16(0);
            }
            rd2.Close();

            con.Close();

            if (es == "Sexologia")
            {
                NpgsqlConnection conex = CConexion.establecerConexion();
                NpgsqlCommand cmd3 = new NpgsqlCommand(String.Format("Select * from notas_sexualidad ns where ns.id_paciente = {0} and ns.id_medico = {1}",idp, idm), conex);
                NpgsqlDataReader rd3 = cmd3.ExecuteReader();
                gv.ItemsSource = rd3;
            }
            else
            {
                NpgsqlConnection conex = CConexion.establecerConexion();
                NpgsqlCommand cmd3 = new NpgsqlCommand(String.Format("Select * from notas_{0} ns where ns.id_paciente = {1} and ns.id_medico = {2}",es, idp, idm), conex);
                NpgsqlDataReader rd3 = cmd3.ExecuteReader();
                gv.ItemsSource = rd3;
            }

        }


        public static void DarQuitarPermisos(String medico, String paciente, Boolean dar, Boolean quitar, String esp)
        {
            String nombre = "";
            String apellido = "";
            Boolean bandera = false;
            String especialidadD = "";
            int idp = 0;
            int idm = 0;
            
            NpgsqlConnection con = CConexion.establecerConexion();
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

            NpgsqlConnection con1 = CConexion.establecerConexion();
            NpgsqlCommand cmd1 = new NpgsqlCommand(String.Format("select m.id_medico FROM medico m where m.nombre = '{0}' and apellido = '{1}'", nombre,apellido), con1);
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

            NpgsqlCommand cmd6 = new NpgsqlCommand(String.Format("select e.nombre from medico_especialidad me inner join" +
                " especialidad e using(id_especialidad) where me.id_medico = {0}", idm), con1);
            NpgsqlDataReader rd6 = cmd6.ExecuteReader();

            while (rd6.Read())
            {
                especialidadD = rd6.GetString(0);
            }
            rd6.Close();

            if (especialidadD == esp)
            {
                NpgsqlCommand cmd3;
                NpgsqlDataReader rd3;

                if (esp == "Sexologia")
                {
                    cmd3 = new NpgsqlCommand(String.Format("select * FROM permisos_sexualidad where id_medico = {0} and id_paciente = {1}", idm, idp), con1);
                    rd3 = cmd3.ExecuteReader();

                    while (rd3.Read())
                    {
                        bandera = true;
                    }
                    MessageBox.Show(bandera.ToString());
                    rd3.Close();
                }
                else
                {
                    cmd3 = new NpgsqlCommand(String.Format("select * FROM permisos_{0} where id_medico = {1} and id_paciente = {2}", esp, idm, idp), con1);
                    rd3 = cmd3.ExecuteReader();

                    while (rd3.Read())
                    {
                        bandera = true;
                    }
                    rd3.Close();
                }
                con1.Close();

                NpgsqlConnection con2 = CConexion.establecerConexion();
                NpgsqlCommand cmd4;
                NpgsqlCommand cmd5;

                if (bandera && dar)
                {
                    MessageBox.Show("El permiso ya existe");
                    con2.Close();
                }
                else
                {
                    if (bandera && quitar && esp == "Sexologia")
                    {
                        cmd4 = new NpgsqlCommand(String.Format("delete FROM permisos_sexualidad where id_medico ={0} and id_paciente = {1}", idm, idp), con2);
                        cmd4.ExecuteNonQuery();
                        cmd5 = new NpgsqlCommand(String.Format("delete FROM paciente_medico where id_medico ={0} and id_paciente = {1}", idm, idp), con2);
                        cmd5.ExecuteNonQuery();
                        con2.Close();
                        MessageBox.Show("El permiso ha sido removido con éxito");
                    }
                    else
                    {
                        if (bandera && quitar)
                        {
                            cmd4 = new NpgsqlCommand(String.Format("delete FROM permisos_{0} where id_medico ={1} and id_paciente = {2}", esp, idm, idp), con2);
                            cmd4.ExecuteNonQuery();
                            cmd5 = new NpgsqlCommand(String.Format("delete FROM paciente_medico where id_medico ={0} and id_paciente = {1}", idm, idp), con2);
                            cmd5.ExecuteNonQuery();
                            con2.Close();
                            MessageBox.Show("El permiso ha sido removido con éxito");
                        }
                    }

                }

                if (bandera == false && dar)
                {

                    if (bandera == false && dar && esp == "Sexologia")
                    {
                        cmd4 = new NpgsqlCommand(String.Format("insert into permisos_sexualidad (id_paciente,id_medico,permiso) values ({0},{1},true)", idp, idm), con2);
                        cmd4.ExecuteNonQuery();
                        cmd5 = new NpgsqlCommand(String.Format("insert into paciente_medico (id_paciente,id_medico) values ({0},{1})", idp, idm), con2);
                        cmd5.ExecuteNonQuery();
                        con2.Close();
                        MessageBox.Show("El permiso ha sido otorgado con éxito");
                    }
                    else
                    {
                        if (bandera == false && dar)
                        {
                            cmd4 = new NpgsqlCommand(String.Format("insert into permisos_{0} (id_paciente,id_medico,permiso) values ({1},{2},true)", esp, idp, idm), con2);
                            cmd4.ExecuteNonQuery();
                            cmd5 = new NpgsqlCommand(String.Format("insert into paciente_medico (id_paciente,id_medico) values ({0},{1})", idp, idm), con2);
                            cmd5.ExecuteNonQuery();
                            con2.Close();
                            MessageBox.Show("El permiso ha sido otorgado con éxito");
                        }
                    }


                }
                else
                {
                    if (bandera == false && quitar)
                    {
                        MessageBox.Show("No puede denegar este permiso por que no existe actualmente");
                        con2.Close();
                    }
                }

            }
            else
            {
                MessageBox.Show("Este medico no es especialista en este campo");
            }

            
                

        }

    }
}

