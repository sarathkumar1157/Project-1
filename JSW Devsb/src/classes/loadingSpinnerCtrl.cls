public class loadingSpinnerCtrl {
    public void spin() {
        long now = datetime.now().gettime();
        while(datetime.now().gettime()-now<5000); // Busy loop for 5000 ms
    }
}