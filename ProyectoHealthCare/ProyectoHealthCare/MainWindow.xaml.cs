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
using System.Windows.Navigation;
using System.Windows.Shapes;
using Npgsql;
using ProyectoHealthCare.Clases;

namespace ProyectoHealthCare
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            String correoInsert = correoelectronico.Text;
            String contraInsert = contra.Password.ToString();
            Application.Current.Properties["correo"] = correoInsert;

            int res;
            res = Clases.CConexion.verificacionUsuario(correoInsert, contraInsert);
            if (res == 2)
            {
                MedicoGeneral MiVentana = new MedicoGeneral();
                MiVentana.Owner = this;
                MiVentana.Show();
                this.Hide();
            }
            else if(res == 1)
            {
                MedicoCualquiera MiVentana = new MedicoCualquiera();
                MiVentana.Owner = this;
                MiVentana.Show();
                this.Hide();
            }
            else
            {
                MessageBox.Show("CORREO O CONTRASEÑA INCORRECTA");
            }
            
        }
    }
}
