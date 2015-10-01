/**
 *
 * @author Diego
 */
public class TrianguloEquilatero extends TrianguloIsosceles {
    
    public TrianguloEquilatero(float lado){
        super(lado, lado);
    }

    @Override
    public boolean validar() {
        // TODO: verificar se equilatero
		    //Nao esquecer de chamar tambem a classe pai para fazer a validacao!

        if ((lados[0] == lados[1]) && (lados[1] == lados[2]) && (super.validar())) {
          return true;
        }

        return false;


    }

}
