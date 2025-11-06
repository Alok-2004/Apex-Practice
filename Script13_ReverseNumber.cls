// Print any Integer number in reverse order. Ex: 789234  => 432987

public with sharing class Script13_ReverseNumber {
    public Script13_ReverseNumber(Integer x) {
        Integer ans = reverseNumber(x);
        System.debug('Reversed Number: ' + ans);
    }

    Integer reverseNumber(Integer x) {
        Integer temp = x;
        Integer rev = 0;

        while(temp > 0) {
            Integer digit = temp - (temp / 10) * 10;
            rev = rev * 10 + digit;
            temp = temp / 10;
        }

        return rev;
    }
}