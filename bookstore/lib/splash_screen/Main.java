class Increase {
    public static long count = 0;
}

class UseIncrease implements Runnable {
    public static void increment() {
        Increase.count++;
        System.out.print(Increase.count + " ");
    }

    public void run() {
        increment();
        increment();
        increment();
    }
}

class SynchronizedUseIncrease implements Runnable {
    public static synchronized void increment() {
        Increase.count++;
        System.out.print(Increase.count + " ");
    }

    public void run() {
        increment();
        increment();
        increment();
    }
}

public class Main {
    public static void main(String[] args){ UseIncrease i1=new UseIncrease(); Thread t1=new Thread(i1);
        Thread t2=new Thread(i1); Thread t3=new Thread(i1); t1.start();
        t2.start();
        t3.start(); Increase.count = 0;
        SynchronizedUseIncrease	sync1=new SynchronizedUseIncrease();
        Thread t4 = new Thread(sync1); Thread t5 = new Thread(sync1); Thread t6 = new Thread(sync1); t4.start();
        t5.start();
        t6.start();
    }