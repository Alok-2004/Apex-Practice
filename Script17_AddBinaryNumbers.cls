public class Script17_AddBinaryNumbers {
    public static void Script17_AddBinaryNumbers() {
        String a = '100101';
        String b = '0101101';
        System.debug('Sum = ' + addBinary(a, b));
    }

    public static String addBinary(String a, String b) {
        Integer i = a.length() - 1;
        Integer j = b.length() - 1;
        Integer carry = 0;
        String result = '';

        while (i >= 0 || j >= 0 || carry != 0) {
            Integer sum = carry;
            if (i >= 0) sum += Integer.valueOf(String.valueOf(a.charAt(i--)));
            if (j >= 0) sum += Integer.valueOf(String.valueOf(b.charAt(j--)));

            Integer bit = Math.mod(sum, 2);
            result = String.valueOf(bit) + result;
            carry = sum / 2;
        }

        return result;
    }
}
