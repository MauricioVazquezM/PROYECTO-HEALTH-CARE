﻿using ProyectoHealthCare.Clases;
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
    /// Interaction logic for MedicoCualquiera.xaml
    /// </summary>
    public partial class MedicoCualquiera : Window
    {
        public MedicoCualquiera()
        {
            InitializeComponent();
            CConexion.llenarComboPacientes(pacientes);
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
