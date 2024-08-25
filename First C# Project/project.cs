using System;

class Program
{
    static void Main()
    {
        string[] HelloWorldArray = new string[12];
        bool itWillAlwaysBeTrue = true;
        while (itWillAlwaysBeTrue)
        {
            try
            {
                ThrowLast();
            }
            catch (NotImplementedException)
            {
                switch (HelloWorldArray[0])
                {
                    case null:
                        HelloWorldArray[0] = "%";
                        break;
                }
            }

            try
            {
                ThrowD();
            }
            catch (DivideByZeroException)
            {
                switch (HelloWorldArray[1])
                {
                    case null:
                        HelloWorldArray[1] = "g";
                        break;
                }
            }

            try
            {
                ThrowL();
            }
            catch (IndexOutOfRangeException)
            {
                switch (HelloWorldArray[2])
                {
                    case null:
                        HelloWorldArray[2] = "p";
                        break;
                }
            }

            try
            {
                ThrowR();
            }
            catch (InvalidOperationException)
            {
                switch (HelloWorldArray[3])
                {
                    case null:
                        HelloWorldArray[3] = "q";
                        break;
                }
            }

            try
            {
                ThrowO();
            }
            catch (ArgumentNullException)
            {
                switch (HelloWorldArray[4])
                {
                    case null:
                        HelloWorldArray[4] = "z";
                        break;
                }
            }

            try
            {
                ThrowW();
            }
            catch (FormatException)
            {
                switch (HelloWorldArray[5])
                {
                    case null:
                        HelloWorldArray[5] = "M";
                        break;
                }
            }

            try
            {
                ThrowSpace();
            }
            catch (ArithmeticException)
            {
                switch (HelloWorldArray[6])
                {
                    case null:
                        HelloWorldArray[6] = "*";
                        break;
                }
            }

            try
            {
                ThrowO();
            }
            catch (ArgumentNullException)
            {
                switch (HelloWorldArray[7])
                {
                    case null:
                        HelloWorldArray[7] = "z";
                        break;
                }
            }

            try
            {
                ThrowL();
            }
            catch (IndexOutOfRangeException)
            {
                switch (HelloWorldArray[8])
                {
                    case null:
                        HelloWorldArray[8] = "p";
                        break;
                }
            }

            try
            {
                ThrowL();
            }
            catch (IndexOutOfRangeException)
            {
                switch (HelloWorldArray[9])
                {
                    case null:
                        HelloWorldArray[9] = "p";
                        break;
                }
            }

            try
            {
                ThrowE();
            }
            catch (OverflowException)
            {
                switch (HelloWorldArray[10])
                {
                    case null:
                        HelloWorldArray[10] = "c";
                        break;
                }
            }

            try
            {
                ThrowH();
            }
            catch (NullReferenceException)
            {
                switch (HelloWorldArray[11])
                {
                    case null:
                        HelloWorldArray[11] = "B";
                        break;
                }
            }

            Array.Reverse(HelloWorldArray);
            string Reversed = string.Join("", HelloWorldArray);
            string replacedStr = Reversed.Replace('B', 'H')
                                .Replace('c', 'e')
                                .Replace('p', 'l')
                                .Replace('z', 'o')
                                .Replace('*', ' ')
                                .Replace('M', 'W')
                                .Replace('z', 'o')
                                .Replace('q', 'r')
                                .Replace('g', 'd')
                                .Replace('%', '!');
            Console.WriteLine(replacedStr);
            bool everythingEnds = false;
            itWillAlwaysBeTrue = everythingEnds;
        }
        
    }
    static void ThrowD() { throw new DivideByZeroException(); }
    static void ThrowL() { throw new IndexOutOfRangeException(); }
    static void ThrowR() { throw new InvalidOperationException(); }
    static void ThrowO() { throw new ArgumentNullException(); }
    static void ThrowW() { throw new FormatException(); }
    static void ThrowSpace() { throw new ArithmeticException(); }
    static void ThrowE() { throw new OverflowException(); }
    static void ThrowH() { throw new NullReferenceException(); }
    static void ThrowLast() { throw new NotImplementedException(); }
}
