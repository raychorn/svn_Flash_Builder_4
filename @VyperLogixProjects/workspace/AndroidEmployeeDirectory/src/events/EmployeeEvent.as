/**
 *  Author: Christophe Coenraets, http://coenraets.org
 */
package events
{
	import flash.events.Event;
	
	import model.Employee;
	
	public class EmployeeEvent extends Event
	{
		public static const SELECT:String = "selectContact";
		public static const REPORTS:String = "directReports";
	
		public var employee:Employee;
	
		public function EmployeeEvent(type:String, employee:Employee, bubbles:Boolean = true, cancelable:Boolean = true)
   		{
			super(type, bubbles, cancelable);
   			this.employee = employee;
		}
	}
}