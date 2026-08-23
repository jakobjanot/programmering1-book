#import "../style.typ": *

= Input og IO.readln

Indtil nu har vores programmer kun kunne udskrive information. Men for at lave virkelig interaktive programmer har vi brug for at kunne læse input fra brugeren. I dette kapitel lærer vi at læse input med `IO.readln` og hvordan vi konverterer mellem forskellige datatyper.

== Casting - konvertering mellem datatyper

Før vi dykker ned i input, er det vigtigt at forstå hvordan Java håndterer konvertering mellem forskellige datatyper.

=== Implicit casting (automatisk)

Nogle konverteringer sker automatisk uden tab af information:

```java
int x = 4;
double y = x;  // y er nu 4.0 - går godt
IO.println(y);  // 4.0
```

Dette virker fordi en `double` kan indeholde alle værdier som en `int` kan, plus decimaler.

=== Eksplicit casting (manuel)

Andre konverteringer kan resultere i tab af information og skal gøres eksplicit:

```java
double x = 2.7;
int y = (int) x;  // y er nu 2 - decimaldelen forsvinder
IO.println(y);  // 2
```

#exercise(title: "Casting quiz")[
Gæt hvad følgende kode udskriver, eller om den giver en fejl:

1. ```java
   int a = 5;
   double b = a;
   IO.println(b);
   ```

2. ```java
   double a = 5.5;
   int b = (int) a;
   IO.println(b);
   ```

3. ```java
   char a = 'A';
   int b = a;
   IO.println(b);  // Hint: ASCII værdi
   ```

4. ```java
   int a = 66;
   char b = (char) a;
   IO.println(b);  // Hvad er ASCII 66?
   ```
]

=== Parsing - konvertering fra String

Strings kan ikke castes direkte til tal. I stedet bruger vi parsing:

```java
String x = "4";
int y = Integer.parseInt(x);     // y er nu 4
double z = Double.parseDouble("2.7");  // z er nu 2.7
boolean w = Boolean.parseBoolean("true");  // w er nu true
```

Hvis strengen ikke kan konverteres, får vi en fejl:
```java
int x = Integer.parseInt("hello");  // Fejl!
```

== Læsning af input med IO.readln

Klassen `java.lang.IO` giver os, udover `IO.print` og `IO.println`, også metoden `IO.readln`, som læser en hel linje tekst fra brugeren:

```java
void main() {
    String name = IO.readln("Indtast dit navn: ");
    IO.println("Hej " + name + "!");
}
```

`IO.readln(prompt)` udskriver først prompten, og returnerer derefter det, brugeren skriver, som en `String` - uden linjeskiftet til sidst. Der findes også en variant uden prompt, `IO.readln()`.

#note[
`IO`-klassen ligger i pakken `java.lang`, som altid er tilgængelig - du skal ikke importere noget for at bruge `IO.readln`.
]

=== Læsning af tal

Da `IO.readln` altid returnerer en `String`, skal vi selv parse resultatet til det, vi har brug for:

```java
void main() {
    String ageText = IO.readln("Indtast din alder: ");
    int age = Integer.parseInt(ageText);

    IO.println("Om et år er du " + (age + 1) + " år gammel!");
}
```

#exercise(title: "Fodboldresultater")[
Lav et program der læser fodboldresultater:

1. Bed brugeren om at indtaste hjemmeholdets mål med `IO.readln`
2. Bed brugeren om at indtaste udeholdets mål med `IO.readln`
3. Parse begge svar til `int` med `Integer.parseInt`
4. Udskriv resultatet pænt:
   ```
   Hjemmehold: 3 mål
   Udehold: 1 mål
   ```
]

== Betingelser med input

Input bliver særligt kraftfuldt når vi kombinerer det med betingelser (som vi lærer mere om i næste kapitel):

```java
int home = Integer.parseInt(IO.readln("Hjemmeholdets mål: "));
int away = Integer.parseInt(IO.readln("Udeholdets mål: "));

IO.println("Hjemmehold: " + home + " mål");
IO.println("Udehold: " + away + " mål");

if (home > away) {
    IO.println("Hjemmeholdet vandt!");
} else if (away > home) {
    IO.println("Udeholdet vandt!");
} else {
    IO.println("Det blev uafgjort!");
}
```

#exercise(title: "Hvem vandt?")[
Udvid dit fodboldresultat-program:

1. Læs hjemme- og udeholdets mål fra brugeren
2. Bestem og udskriv hvem der vandt kampen
3. Test med forskellige resultater

Forklar: Hvorfor behøver vi ikke tjekke `away == home` under `else`?
]

== Interaktive programmer

Med `IO.readln` kan vi lave programmer der reagerer på brugerens input:

```java
void main() {
    String name = IO.readln("Hvad hedder du? ");
    int age = Integer.parseInt(IO.readln("Hvor gammel er du? "));
    double height = Double.parseDouble(IO.readln("Hvor høj er du (i meter)? "));

    IO.println("\nDine oplysninger:");
    IO.println("Navn: " + name);
    IO.println("Alder: " + age + " år");
    System.out.printf("Højde: %.2f meter%n", height);

    if (age >= 18) {
        IO.println("Du er myndig!");
    } else {
        IO.println("Du er under 18 år.");
    }
}
```

#note[
`IO` har ingen `printf`-metode til formateret udskrift af tal. Har vi brug for det, bruger vi stadig `System.out.printf`, som vi lærte i sidste kapitel.
]

=== Fejlhåndtering

Pas på at brugeren indtaster den rigtige type data:

```java
String input = IO.readln("Indtast et tal: ");

// Dette vil fejle hvis brugeren skriver "hello"
int number = Integer.parseInt(input);
```

I begyndelsen kan du bede brugeren om at indtaste det rigtige format. Senere lærer du om try-catch til at håndtere fejl.

#exercise(title: "Prinsessen skal giftes")[
Prinsessen skal giftes og har specifikke krav til sin prins. Implementer følgende metode:

```java
boolean canMarry(int age, boolean isHandsome,
                  boolean isBrave, boolean isRich) {
    if (age < 18) {
        return false;
    }
    if (isHandsome) {
        if (isBrave || isRich) {
            return true;
        }
    }
    return false;
}
```

Test med disse kandidater:
- Prins Charming (20 år, flot, ikke modig, ikke rig)
- Prins Ib (22 år, ikke flot, modig, ikke rig)  
- Prins Bieber (31 år, flot, ikke modig, rig)
- Prins Blop (17 år, flot, modig, rig)

Hvem kan prinsessen gifte sig med?
]

== Calculator eksempel

Lad os lave en simpel lommeregner:

```java
void main() {
    double a = Double.parseDouble(IO.readln("Indtast første tal: "));
    String operator = IO.readln("Indtast operation (+, -, *, /): ");
    double b = Double.parseDouble(IO.readln("Indtast andet tal: "));

    double result = 0;

    if (operator.equals("+")) {
        result = a + b;
    } else if (operator.equals("-")) {
        result = a - b;
    } else if (operator.equals("*")) {
        result = a * b;
    } else if (operator.equals("/")) {
        if (b != 0) {
            result = a / b;
        } else {
            IO.println("Fejl: Division med nul!");
            return;
        }
    } else {
        IO.println("Ukendt operation: " + operator);
        return;
    }

    System.out.printf("%.2f %s %.2f = %.2f%n", a, operator, b, result);
}
```

== Integer division og modulo

Når du arbejder med heltal, skal du være opmærksom på integer division:

```java
int a = 7;
int b = 3;

int result1 = a / b;          // 2 (ikke 2.33...)
double result2 = (double) a / b;  // 2.33...

int remainder = a % b;        // 1 (rest ved division)
```

Modulo-operatoren (`%`) giver resten ved division og er nyttig til mange ting:
- Tjekke om et tal er lige: `number % 2 == 0`
- Få sidste ciffer: `number % 10`
- Cyklisk gentagelse: `index % arrayLength`

#exercise(title: "Mængderabat")[
Lav et program der beregner mængderabat:

1. Læs antal varer og pris per vare
2. Beregn totalprisen
3. Giv rabat baseret på antal:
   - 10+ varer: 10% rabat
   - 50+ varer: 20% rabat
   - 100+ varer: 25% rabat
4. Vis både original pris, rabat og slutpris
]

== At læse flere værdier på én linje

`IO.readln` læser altid én hel linje som én `String`. Hvis brugeren skal indtaste flere værdier på samme linje, adskilt af mellemrum, kan vi selv splitte linjen op med `String`-metoden `split`:

```java
void main() {
    String line = IO.readln("Indtast to tal adskilt af mellemrum: ");
    String[] parts = line.split(" ");

    int a = Integer.parseInt(parts[0]);
    int b = Integer.parseInt(parts[1]);

    IO.println("Summen er: " + (a + b));
}
```

Vi lærer mere om arrays som `parts` i det næste kapitel.

== Sammenfatning

I dette kapitel har vi lært:

- *Casting*: Konvertering mellem datatyper (implicit og eksplicit)
- *Parsing*: Konvertering fra String til andre typer
- *IO.readln*: Læsning af input fra brugeren som String
- *Interaktive programmer*: Kombination af input, beregninger og output
- *Fejlhåndtering*: Hvad der kan gå galt med input

Med disse værktøjer kan du nu lave programmer der interagerer med brugeren og reagerer på deres input. I næste kapitel lærer vi mere om betingelser (`if`/`else`), som gør det muligt at lave endnu mere intelligente programmer der træffer beslutninger baseret på input.
