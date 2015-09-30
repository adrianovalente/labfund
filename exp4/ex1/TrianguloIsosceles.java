/**
 *
 * @author Diego
 */
public class TrianguloIsosceles extends Triangulo {
    
    public TrianguloIsosceles(float ladoA, float ladoB){
        super(ladoA, ladoA, ladoB);
    }

    @Override
    public boolean validar() {
        // TODO: verificar se isosceles
		    //Nao esquecer de chamar tambem a classe pai para fazer a validacao!

        if (!super.validar()) {
          return false;
        }

        if ((lados[0] == lados[1]) || (lados[2] == lados[1]) || (lados[0] == lados[2])) {
          return true;
        }

        return false;
    }

}
