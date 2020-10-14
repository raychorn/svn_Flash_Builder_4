package com.adobe.dashboard.util
{

	import com.adobe.utils.DateUtil;

	public class DateTimeUtil
	{

		public static function getUSClockTime(hrs:uint, mins:uint):String
		{
			var modifier:String = "PM";
			var minLabel:String = doubleDigitFormat(mins);

			if (hrs > 12)
			{
				hrs = hrs - 12;
			}
			else if (hrs == 0)
			{
				modifier = "AM";
				hrs = 12;
			}
			else if (hrs < 12)
			{
				modifier = "AM";
			}

			return (hrs + ":" + minLabel + " " + modifier);
		}

		public static function doubleDigitFormat(num:uint):String
		{
			if (num < 10)
			{
				return ("0" + num);
			}
			return num.toString();
		}



		public static function formatDateDayMonthDateYear(date:Date):String
		{
			if (!date)
			{
				return "";
			}

			var dateString:String = DateUtil.getFullDayName(date) + ", " +
				DateUtil.getFullMonthName(date) + " " + date.date + ", " +
				date.fullYear;
			return dateString;
		}

		public static function formatDateMonthDateYear(date:Date):String
		{
			var dateString:String = DateUtil.getFullMonthName(date) + " " + date.date + ", " +
				date.fullYear;
			return dateString;
		}

		public static function numberOfDaysInMonth(fullYear:int, monthZeroBased:int):Number
		{
			var d:Date = new Date(fullYear, monthZeroBased + 1, 0);
			return d.date;
		}

		public static function numberOfDaysBetweenDates(date1:Date, date2:Date):Number
		{
			var days:Number = ((date2.time - date1.time) / (1000 * 24 * 60 * 60)) + 1
			return Math.floor(days);
		}

		public static function numberOfMonthsBetweenDates(date1:Date, date2:Date):Number
		{
			var months:Number = (date2.month - date1.month) + ((date2.fullYear - date1.fullYear) * 12) + 1;
			return Math.floor(months);
		}

		public static function findMonday(date:Date):Date
		{
			var dayName:String = DateUtil.getFullDayName(date);
			var dayIndex:int = DateUtil.getFullDayIndex(dayName);
			if (dayIndex == 1)
			{
				return date;
			}
			else
			{
				var monday:Date = new Date(date.fullYear, date.month, date.date - dayIndex + 1);
				return monday;
			}
		}

		public static function getFirstDateOfQuarter(date:Date):Date
		{
			var firstDateOfQuarter:Date;
			switch (date.month)
			{
				case 0:
				case 1:
				case 2:
					firstDateOfQuarter = new Date(date.fullYear, 0);
					break;
				case 3:
				case 4:
				case 5:
					firstDateOfQuarter = new Date(date.fullYear, 3);
					break;
				case 6:
				case 7:
				case 8:
					firstDateOfQuarter = new Date(date.fullYear, 6);
					break;
				case 9:
				case 10:
				case 11:
					firstDateOfQuarter = new Date(date.fullYear, 9);
					break;
			}
			return firstDateOfQuarter;
		}

		public static function getLastDateOfQuarter(date:Date):Date
		{
			var firstDateOfQuarter:Date = getFirstDateOfQuarter(date);
			return new Date(firstDateOfQuarter.fullYear, firstDateOfQuarter.month + 3, 0);
		}

		public static function getFirstDayOfMonth(date:Date):Date
		{
			return new Date(date.fullYear, date.month);
		}

		public static function getLastDayOfMonth(date:Date):Date
		{
			return new Date(date.fullYear, date.month + 1, 0);
		}

		public static function formatQuarterName(date:Date):String
		{
			var q:String = "";
			switch (date.month)
			{
				case 0:
				case 1:
				case 2:
					q = "Q1"
					break;
				case 3:
				case 4:
				case 5:
					q = "Q2"
					break;
				case 6:
				case 7:
				case 8:
					q = "Q3"
					break;
				case 9:
				case 10:
				case 11:
					q = "Q4"
					break;
			}

			q += " – " + date.fullYear;

			return q;
		}

		public static function formatMonthName(date:Date):String
		{
			var months:Array = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];
			return months[date.month];
		}

		public static function buildYearList(startDate:Date, endDate:Date):Array
		{
			var a:Array = [];
			// Add a Date object that matches the year of the startDate
			a.push(new Date(startDate.fullYear, 0, 1));

			// Add more Date objects for each year between startDate and endDate
			if (endDate.fullYear > startDate.fullYear)
			{
				var year:int = startDate.fullYear;
				while (year < endDate.fullYear)
				{
					year++;
					a.push(new Date(year, 0, 1));
				}
			}
			return a;
		}

		public static function buildQuarterList(startDate:Date, endDate:Date):Array
		{
			var a:Array = [];

			// Add more Date objects for each year between startDate and endDate
			if (endDate.fullYear >= startDate.fullYear)
			{
				var year:int = startDate.fullYear;
				var month:int = startDate.month;
				while (year <= endDate.fullYear)
				{
					while (month <= 12)
					{
						if (month == 12 || month > endDate.month)
						{
							month = 0;
							year++;
							break;
						}
						else
						{
							a.push(new Date(year, month, 1));
						}

						month = month + 3;
					}
				}
			}
			return a;
		}

		public static function buildMonthList(startDate:Date, endDate:Date):Array
		{
			var a:Array = [];

			// Add more Date objects for each year between startDate and endDate
			if (endDate.fullYear >= startDate.fullYear)
			{
				var year:int = startDate.fullYear;
				var month:int = startDate.month;
				while (year <= endDate.fullYear)
				{
					while (month <= 12)
					{
						if (month == 12 || month > endDate.month)
						{
							month = 0;
							year++;
							break;
						}
						else
						{
							a.push(new Date(year, month, 1));
						}

						month++;
					}
				}
			}
			return a;
		}

	}
}