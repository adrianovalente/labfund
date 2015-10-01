package mvn.dispositivo;

import mvn.Bits8;
import mvn.Dispositivo;
import mvn.controle.MVNException;

/**
 *
 * @author mjunior
 */
public class Fibonacci implements Dispositivo {
    private Bits8 v0, v1;

    public Fibonacci(){
        v0 = new Bits8(0);
        v1 = new Bits8(0);
    }

    /**
     *
     * @param in
     *          O valor a ser escrito.
     * @throws MVNException
     *          Caso ocorra algum erro.
     */
    @Override
    public void escrever(Bits8 in) throws MVNException {
        v0 = v1;
        v1 = in;
    }

    /**
     *
     * @return O proximo numero da sequenca Fibonacci.
     * @throws MVNException
     *          Caso orocca algum erro.
     */
    @Override
    public Bits8 ler() throws MVNException {
        Bits8 next = new Bits8(v1.toInt() + v0.toInt());
        escrever(next);
        return next;
    }

    /**
     * Retorna TRUE.<br/>
     * <br/>
     * <b>Pré-condição</b>: Nenhuma.<br/>
     * <b>Pós-condição</b>: Retorna verdadeiro.
     *
     * @return True.
     */
    @Override
    public boolean podeLer() {
        return true;
    }

    /**
     * Retorna TRUE.<br/>
     * <br/>
     * <b>Pré-condição</b>: Nenhuma.<br/>
     * <b>Pós-condição</b>: Retorna verdadeiro.
     *
     * @return True.
     */
    @Override
    public boolean podeEscrever() {
        return true;
    }

    /**
     * Reinicia o dispositivo a seu estado inicial.
     * @throws MVNException
     */
    @Override
    public void reset() throws MVNException {
        v0 = new Bits8(0);
        v1 = new Bits8(0);
    }

    /**
     *
     * @param val
     *          O numero de posiçoes a ser avançadas.
     * @return
     * @throws MVNException
     */
    @Override
    public Bits8 skip(Bits8 val) throws MVNException {
        for (int i = 0; i < val.toInt(); i++)
            ler();
        return ler();
    }

    @Override
    public Bits8 position() throws MVNException {
        return v0;
    }

    @Override
    public Bits8 size() throws MVNException {
        return v1;
    }

    @Override
    public String toString(){
        return " {v0: "+v0.toInt()+", v1: "+v1.toInt()+"}";
    }
}
