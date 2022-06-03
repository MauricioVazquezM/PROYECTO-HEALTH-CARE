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

        private void acceso_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
