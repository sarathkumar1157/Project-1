global class ASMNotifSchedule implements Schedulable {
   global void execute(SchedulableContext SC) {
      if((system.today().day() >= 28 && system.today().day() <= 31) || (system.today().day() >= 1 && system.today().day() <= 5)){
          ASMNotifClass notif = new ASMNotifClass();
          Database.executeBatch(notif,10);
      }
   }
}