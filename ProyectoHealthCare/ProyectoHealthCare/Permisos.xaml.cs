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
    /// Interaction logic for Permisos.xaml
    /// </summary>
    public partial class Permisos : Window
    {
        public Permisos()
        {
            InitializeComponent();
            Clases.CConexion.llenarComboPacientesGen(pacientesNom);
            Clases.CConexion.llenarComboDoctoresGen(nomDoctor);
            especialidad.Items.Add("Nutricion");
            especialidad.Items.Add("Psicologia");
            especialidad.Items.Add("Ginecologia");
            especialidad.Items.Add("Sexologia");
            especialidad.Items.Add("Sueno");
            especialidad.SelectedIndex = 0;
        }

        private void aplicar_Click(object sender, RoutedEventArgs e)
        {
            String paciente = pacientesNom.Text;
            String medico = nomDoctor.Text;
            Boolean d = dar.IsChecked.Value;
            Boolean q = quitar.IsChecked.Value;
            String esp = especialidad.Text;
            Clases.CConexion.DarQuitarPermisos(medico,paciente,d,q,esp);
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
            String correo = Application.Current.Properties["correo"].ToString();


                MedicoGeneral ventana = new MedicoGeneral();
                ventana.Owner = this;
                ventana.Show();
                this.Hide();

        }
    }
}
