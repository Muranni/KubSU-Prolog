open System

let easyDivider elem = //Проверка делителя на простоту
    let rec elemDivisionCheck elem previous = 
        if (elem = 1) then 
            false
        else
            if (elem / 2 + 1 = previous) then 
                true
            else
                if (elem % previous = 0) then 
                    false
                else 
                    elemDivisionCheck elem (previous + 1)
    elemDivisionCheck elem 2

let rec elemDivision elem = //Последовательное деление числа на простые делители
    let rec elemNextDivision elem divider previous counter =
        if (divider > elem && elem <> 1) then 
            -1
        else
            if(easyDivider elem) then 
                if (elem = previous) then 
                    counter
                else
                    counter + 1
            else 
                if (elem = 1) then 
                    counter
                else
                    if (easyDivider divider = true && elem % divider = 0) then 
                        if (divider = previous) then 
                            elemNextDivision (elem / divider) divider previous (counter)
                        else
                            elemNextDivision (elem / divider) divider divider (counter + 1)
                    else
                        elemNextDivision elem (divider + 1) divider counter
    elemNextDivision elem 2 1 0

let rec elemCheck elem limit counter = //Поиск наибольшего из 4 элементов, удовлетворяющих условию задачи
    if (counter = limit) then 
        elem;
    else
        let elemCounter = 
            elemDivision elem 
        if (elemCounter = limit) then 
            elemCheck (elem + 1) limit (counter + 1)
        else
            elemCheck (elem + 1) limit 0

[<EntryPoint>]
let main argv =
    let rec output elem amount= //Вывод элементов на экран
        if (amount = 0) then 
            ();
        else
            Console.Write(elem - amount)
            Console.Write("  ")
            output elem (amount - 1)

    let result = 
        elemCheck 2 4 0
    Console.WriteLine("Первые четыре последовательных числа, каждое из которых имеет четыре различных простых делителя: ")
    output result 4
    Console.WriteLine()
    0