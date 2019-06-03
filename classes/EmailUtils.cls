public class EmailUtils {
    public static boolean isValidEmail(String email) {
        // Very basic validation
        return email.contains('@');
    }
}