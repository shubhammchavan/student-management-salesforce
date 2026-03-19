trigger EnrollmentTrigger on Enrollment__c (after insert) {

    Map<Id, Course__c> courseMap = new Map<Id, Course__c>();

    // Collect unique course ids
    for(Enrollment__c enr : Trigger.new)
    {
        if(enr.Course__c != null)
        {
            courseMap.put(enr.Course__c, null);
        }
    }

    // Query courses
    List<Course__c> courseList = [
        SELECT Id, Available_Seats__c
        FROM Course__c
        WHERE Id IN :courseMap.keySet()
    ];

    // Put actual records in map
    for(Course__c c : courseList)
    {
        courseMap.put(c.Id, c);
    }

    // Update seats
    for(Enrollment__c enr : Trigger.new)
    {
        if(courseMap.containsKey(enr.Course__c))
        {
            Course__c c = courseMap.get(enr.Course__c);

            if(c.Available_Seats__c != null && c.Available_Seats__c > 0)
            {
                c.Available_Seats__c = c.Available_Seats__c - 1;
            }
        }
    }

    // Update once (no duplicates)
    update courseMap.values();
}