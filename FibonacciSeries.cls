public class FibonacciSeries {
    public FibonacciSeries() {
        System.debug('Fibonacci Series Class Initialized');
    }
    
    public static List<Integer> generateFibonacci(Integer n) {
        List<Integer> series = new List<Integer>();
        
        if (n <= 0) return series;
        if (n >= 1) series.add(0);
        if (n >= 2) series.add(1);
        
        for (Integer i = 2; i < n; i++) {
            Integer next = series[i - 1] + series[i - 2];
            series.add(next);
        }
        return series;
    }
}
