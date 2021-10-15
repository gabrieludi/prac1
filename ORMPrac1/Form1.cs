using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ORMPrac1
{
   
    public partial class Form1 : Form
    {
        public List<Model.ALUMNO> oAlumno;
        public List<Model.APODERADO> oApoderado;
        public List<Model.INSCRITO> oInscrito;
        public List<Model.CURSO> oCurso;
        int indice = 0;
        public Form1()
        {
            InitializeComponent();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            comboBox1.Items.Add("ALUMNO");
            comboBox1.Items.Add("APODERADO");
            comboBox1.Items.Add("CURSO");
            comboBox1.Items.Add("INSCRITO");
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (Model.DBPrac1Entities db = new Model.DBPrac1Entities())
            {
                switch(comboBox1.SelectedIndex)
                {
                    case 0:
                        oAlumno = db.ALUMNO.ToList();
                        break;
                    case 1:
                        oApoderado = db.APODERADO.ToList();
                        break;
                    case 2:
                        oCurso = db.CURSO.ToList();
                        break;
                    case 3:
                        oInscrito = db.INSCRITO.ToList();
                        break;
                }
            }
            indice = 0;
            Llenar();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            indice--;
            Llenar();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            indice--;
            Llenar();
        }
        public void Llenar()
        {
            if (indice < 0)
                indice = 0;

            string cadena = "";

            ///en el combobox se seleccionan de la tabla la informacion de cada alumno y se trae con lo escrito en ""
            ///este tiene un mayor o = siendo este el contador de los alumnos el cual buscara
            ///
            switch (comboBox1.SelectedIndex)
            {

                case 0:
                    if (indice >= oAlumno.Count)
                        indice = oAlumno.Count - 1;
                    cadena =  oAlumno[indice].Id.ToString() + " el nombre del estudiante es: " + oAlumno[indice].Nombre + ", la ciudad del alumno es: " + oAlumno[indice].Ciudad + ", el alumno tiene: " + oAlumno[indice].Edad + " años.";
                    break;
                case 1:
                    if (indice >= oApoderado.Count)
                        indice = oApoderado.Count - 1;

                    using (Model.DBPrac1Entities db = new Model.DBPrac1Entities())
                    {
                        oAlumno = db.ALUMNO.ToList();
                        cadena = oApoderado[indice].Id.ToString() + " nombre del apoderado: " + oApoderado[indice].Nombre + ", es el apoderado de: " + oAlumno.Find(a => a.Id == (int)oApoderado[indice].Id_Alumno).Nombre;
                    }
                    break;
                case 2:
                    if (indice >= oCurso.Count)
                        indice = oCurso.Count - 1;
                    cadena = oCurso[indice].Cod.ToString() + " nombre del curso: " + oCurso[indice].Nombre + oCurso[indice].Fecha_Inicio + " duracion del curso " + oCurso[indice].Duracion + " Horas" + oCurso[indice].Valor + " Pesos.";
                    break;
                case 3:
                    if (indice >= oInscrito.Count)
                        indice = oInscrito.Count - 1;
                    using (Model.DBPrac1Entities db = new Model.DBPrac1Entities())
                    { 
                        oAlumno = db.ALUMNO.ToList();
                        oCurso = db.CURSO.ToList();
                        cadena = oInscrito[indice].Id.ToString() + " el alumno: " + oAlumno.Find(a => a.Id == (int)oInscrito[indice].Id_Alumno).Nombre + " su curso; " + oCurso.Find(a => a.Cod == (int)oInscrito[indice].Cod_Curso).Nombre;
                    }
                    break;
            }
            textBox1.Text = cadena;
        }
    }
    
 
}
