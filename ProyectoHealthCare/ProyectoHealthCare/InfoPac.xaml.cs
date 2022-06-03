using Npgsql;
using System;
using System.Collections.Generic;
using System.Data;
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
    /// Interaction logic for InfoPac.xaml
    /// </summary>
    public partial class InfoPac : Window
    {
        public InfoPac()
        {
            InitializeComponent();
            String aux = Application.Current.Properties["paciente"].ToString();
            nombre.Content = aux;
            especialidad.Items.Add("Nutricion");
            especialidad.Items.Add("Psicologia");
            especialidad.Items.Add("Ginecologia");
            especialidad.Items.Add("Sexologia");
            especialidad.Items.Add("Sueno");
            especialidad.SelectedIndex = 0;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            String esp = especialidad.Text;
            Clases.CConexion.DatosContactos(grid);
        }
    }
}
