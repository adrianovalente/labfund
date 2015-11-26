/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mvn.dispositivo;

import mvn.Bits8;
import mvn.Dispositivo;
import mvn.controle.MVNException;

/**
 *
 * @author mjunior
 */
public class Counter implements Dispositivo {
    Bits8 count;

    public Counter(){
        this.count = new Bits8(0);
    }

    @Override
    public void escrever(Bits8 in) throws MVNException {
        this.count = in;
    }

    @Override
    public Bits8 ler() throws MVNException {
        return this.count;
    }

    @Override
    public boolean podeLer() {

        return this.count.toInt() < 255;
    }

    @Override
    public boolean podeEscrever() {
        return true;
    }

    @Override
    public void reset() throws MVNException {
        this.count.clear();
    }

    @Override
    public Bits8 skip(Bits8 val) throws MVNException {
        if(this.count.toInt() < 255)
            this.count.add(val);
        return this.count;
    }

    @Override
    public Bits8 position() throws MVNException {
        if(this.count.toInt() < 255)
            this.count.add(new Bits8(1));
        return this.count;
    }

    @Override
    public Bits8 size() throws MVNException {
        int num = 255 - this.count.toInt();
        Bits8 remaining = new Bits8(num);
        return remaining;
    }
}
