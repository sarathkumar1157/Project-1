global class LazyLoading{
    global static Map<Integer,String> monthmap  = new Map<Integer,String>();
    public static String getmonthname(Integer monthnum){
        LazyLoading.monthmap.put(1,'January');
        LazyLoading.monthmap.put(2,'February');
        LazyLoading.monthmap.put(3,'March');
        LazyLoading.monthmap.put(4,'April');
        LazyLoading.monthmap.put(5,'May');
        LazyLoading.monthmap.put(6,'June');
        LazyLoading.monthmap.put(7,'July');
        LazyLoading.monthmap.put(8,'August');
        LazyLoading.monthmap.put(9,'September');
        LazyLoading.monthmap.put(10,'October');
        LazyLoading.monthmap.put(11,'November');
        LazyLoading.monthmap.put(12,'December');
        return LazyLoading.monthmap.get(monthnum);
    }
}