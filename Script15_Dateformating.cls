// WAP to enter a startDate='06:07:55 2-jan-2016' & endDate='07:08:55 5-feb-2016' and display the difference between two dates in Years, months, days, hours, minutes,seconds.

public with sharing class Script15_Dateformating {
    public Script15_Dateformating(String StartDate, String EndDate){
        Integer diff = differenceBetweenDates(StartDate, EndDate);
        System.debug('Difference between dates: ' + diff + ' days');

        calculateFullDifference(StartDate, EndDate);
    }

    Integer differenceBetweenDates(String StartDate, String EndDate){
        DateTime startDt = parseCustomDateTime(StartDate);
        DateTime endDt   = parseCustomDateTime(EndDate);

        Long diffMillis = endDt.getTime() - startDt.getTime();
        Integer diffDays = (diffMillis / (1000 * 60 * 60 * 24)).intValue();
        return diffDays;
    }

    // Full breakdown: Years, Months, Days, Hours, Minutes, Seconds
    void calculateFullDifference(String StartDate, String EndDate) {
        DateTime startDt = parseCustomDateTime(StartDate);
        DateTime endDt   = parseCustomDateTime(EndDate);

        Integer years  = endDt.year()  - startDt.year();
        Integer months = endDt.month() - startDt.month();
        Integer days   = endDt.day()   - startDt.day();

        if (days < 0) {
            months--;
            days += Date.daysInMonth(startDt.year(), startDt.month());
        }
        if (months < 0) {
            years--;
            months += 12;
        }

        Integer hours   = endDt.hour()   - startDt.hour();
        Integer minutes = endDt.minute() - startDt.minute();
        Integer seconds = endDt.second() - startDt.second();

        if (seconds < 0) {
            minutes--;
            seconds += 60;
        }
        if (minutes < 0) {
            hours--;
            minutes += 60;
        }
        if (hours < 0) {
            days--;
            hours += 24;
        }

        System.debug('Full Difference: ' + 
            years + ' Years, ' + 
            months + ' Months, ' + 
            days + ' Days, ' + 
            hours + ' Hours, ' + 
            minutes + ' Minutes, ' + 
            seconds + ' Seconds'
        );
    }

    private static DateTime parseCustomDateTime(String dtStr) {
        List<String> parts = dtStr.split(' ');
        List<String> timeParts = parts[0].split(':');
        List<String> dateParts = parts[1].split('-');

        Integer hour   = Integer.valueOf(timeParts[0]);
        Integer minute = Integer.valueOf(timeParts[1]);
        Integer second = Integer.valueOf(timeParts[2]);
        Integer day    = Integer.valueOf(dateParts[0]);
        Integer month  = getMonthNum(dateParts[1]);
        Integer year   = Integer.valueOf(dateParts[2]);

        return DateTime.newInstance(year, month, day, hour, minute, second);
    }

    private static Integer getMonthNum(String mon) {
        Map<String, Integer> months = new Map<String, Integer>{
            'jan' => 1, 'feb' => 2, 'mar' => 3, 'apr' => 4,
            'may' => 5, 'jun' => 6, 'jul' => 7, 'aug' => 8,
            'sep' => 9, 'oct' => 10, 'nov' => 11, 'dec' => 12
        };
        return months.get(mon.toLowerCase());
    }
}
