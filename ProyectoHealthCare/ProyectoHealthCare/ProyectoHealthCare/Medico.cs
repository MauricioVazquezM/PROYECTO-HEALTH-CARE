using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Windows;

namespace ProyectoHealthCare.ProyectoHealthCare
{
    internal class Medico
    {
        int id_medico;
        string nombre;
        string apellido;
        string direccion;
        int numero;
        string posicion;
        int edad;
        public Medico(int id_medico, string nombre, string apellido, string direccion, int numero, string posicion, int edad)
        {
            this.id_medico = id_medico;
            this.nombre = nombre;
            this.apellido = apellido;
            this.direccion = direccion;
            this.numero = numero;
            this.posicion = posicion;
            this.edad = edad;
        }

        public Medico()
        {
        }

        public string alta(Medico a)
        {
            string res = "";
            SqlConnection con = Conexion.agregarConexion();
            SqlCommand cmm1;
            string query;
            try
            {
                query = string.Format("insert into medico values ('{0}', '{1}', '{2}')",
                   a.id_medico, a.nombre, a.apellido, a.direccion, a.numero, a.posicion, a.edad);
                cmm1 = new SqlCommand(query, con);
                int res1 = cmm1.ExecuteNonQuery();
                if (res1 > 0)
                    res = "alta exitosa";
                else
                    res = "no se pudo hacer el alta";
            }
            catch (Exception e)
            {
                MessageBox.Show("no se pudo dar de alta" + e);
            }
            return res;
        }
    }
