public class PaymentService {

    public static Decimal getTotalPayment(Id enrollmentId)
    {
        Decimal totalAmount = 0;

        List<Payment__c> payments = [
            SELECT Amount__c
            FROM Payment__c
            WHERE Enrollment__c = :enrollmentId
        ];

        for(Payment__c p : payments)
        {
            if(p.Amount__c != null)
            {
                totalAmount += p.Amount__c;
            }
        }

        return totalAmount;
    }
public static Integer getPaymentCount(Id enrollmentId)
{
    List<Payment__c> payments = [
        SELECT Id
        FROM Payment__c
        WHERE Enrollment__c = :enrollmentId
    ];

    return payments.size();
}
}