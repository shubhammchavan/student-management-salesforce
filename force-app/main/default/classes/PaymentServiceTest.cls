@isTest
public class PaymentServiceTest {

    @isTest
    static void testPaymentTotal()
    {
        // Create Course
        Course__c c = new Course__c(
            Name = 'Java',
            Available_Seats__c = 10
        );
        insert c;

        // Create Student
        Student__c s = new Student__c(
            Name = 'Test Student'
        );
        insert s;

        // Create Enrollment
        Enrollment__c e = new Enrollment__c(
            Student__c = s.Id,
            Course__c = c.Id,
            Fees_Amount__c = 1000
        );
        insert e;

        // Create Payment
        Payment__c p1 = new Payment__c(
            Enrollment__c = e.Id,
            Amount__c = 500,
            Payment_Status__c = 'Paid'
        );
        insert p1;

        Payment__c p2 = new Payment__c(
            Enrollment__c = e.Id,
            Amount__c = 300,
            Payment_Status__c = 'Paid'
        );
        insert p2;

        // Call Apex Class
        Decimal total = PaymentService.getTotalPayment(e.Id);

        System.assertEquals(800, total);
    }
@isTest
static void testPaymentCount()
{
    Course__c c = new Course__c(
        Name = 'Python',
        Available_Seats__c = 5
    );
    insert c;

    Student__c s = new Student__c(
        Name = 'Student 2'
    );
    insert s;

    Enrollment__c e = new Enrollment__c(
        Student__c = s.Id,
        Course__c = c.Id,
        Fees_Amount__c = 2000
    );
    insert e;

    Payment__c p = new Payment__c(
        Enrollment__c = e.Id,
        Amount__c = 1000,
        Payment_Status__c = 'Paid'
    );
    insert p;

    Integer countPay = PaymentService.getPaymentCount(e.Id);

    System.assertEquals(1, countPay);
}
}