/**
 *
 * @author Diego
 */
public class Triangulo extends Poligono {
    public Triangulo(float ladoA, float ladoB, float ladoC){
        super(new float[]{ladoA, ladoB, ladoC});
    }

    @Override
    public boolean validar() {
        /* Um triangulo deve ter 3 lados e a soma
         * de dois lados deve ser MENOR que o
         * terceiro lado.
         */

		 //TODO: verificar se tem 3 lados e a soma de dois lados quaisquer eh menor do que o terceiro lado
		 //Nao esquecer de chamar tambem a classe pai para fazer a validacao!

     // Chamando a classe pai para validar
     if (!(super.validar())) {
       return false;
     }

     // Validando o número de lados
     if (lados.length != 3) {
       return false;
     }

     if (lados[0] + lados[1] < lados[2]) {
       return false;
     }

     if (lados[1] + lados[2] < lados[0]) {
       return false;
     }

     if (lados[2] + lados[0] < lados[1]) {
       return false;
     }

     return true;

    }


}
