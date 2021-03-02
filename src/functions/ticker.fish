function query_json
    echo $argv[1] | jq -r ".[] | select(.symbol == \"$argv[2]\") | .$argv[3]"
end

function ticker
    if not type -q jq
        echo "'jq' is not in the PATH. (See: https://stedolan.github.io/jq/)"
        exit 1
    end

    if test -z "$argv"
        echo "Usage: ticker AAPL MSFT GOOG BTC-USD"
        return
    end

    if test -z "$NO_COLOR"
        set -q COLOR_BOLD || set COLOR_BOLD "\e[1;37m"
        set -q COLOR_GREEN || set COLOR_GREEN "\e[32m"
        set -q COLOR_RED || set COLOR_RED "\e[31m"
        set COLOR_RESET "\e[00m"
    end

    set FIELDS symbol marketState regularMarketPrice regularMarketChange regularMarketChangePercent \
    preMarketPrice preMarketChange preMarketChangePercent postMarketPrice postMarketChange postMarketChangePercent
    set API_ENDPOINT "https://query1.finance.yahoo.com/v7/finance/quote?lang=en-US&region=US&corsDomain=finance.yahoo.com"

    set symbols (string join ',' $argv) 
    set fields (string join ',' $FIELDS)

    set results (curl --silent "$API_ENDPOINT&fields=$fields&symbols=$symbols" \
        | jq '.quoteResponse .result')

    # echo $results

    for symbol in $argv
        # echo $symbol
        set marketState (query_json "$results" "$symbol" "marketState")

        if test -z "$marketState"
            printf 'No results for symbol "%s"\n' $symbol
            continue
        end

        set preMarketChange (query_json "$results" $symbol 'preMarketChange')
        set postMarketChange (query_json "$results" $symbol 'postMarketChange')

        if test $marketState = "PRE" && test $preMarketChange != "0" && test $preMarketChange != "null"
            set nonRegularMarketSign '*'
            set price (query_json "$results" $symbol 'preMarketPrice')
            set diff $preMarketChange
            set percent (query_json "$results" $symbol 'preMarketChangePercent')
        else if test $marketState != "REGULAR" && test $postMarketChange != "0" && test $postMarketChange != "null"
            set nonRegularMarketSign '*'
            set price (query_json "$results" $symbol 'postMarketPrice')
            set diff $postMarketChange
            set percent (query_json "$results" $symbol 'postMarketChangePercent')
        else
            set nonRegularMarketSign ''
            set price (query_json "$results" $symbol 'regularMarketPrice')
            set diff (query_json "$results" $symbol 'regularMarketChange')
            set percent (query_json "$results" $symbol 'regularMarketChangePercent')
        end

        if test $diff = "0"
            set color ""
        else if test $diff -lt "0"
            set color $COLOR_RED
        else 
            set color $COLOR_GREEN
        end
        
        printf "%-10s$COLOR_BOLD%8.2f$COLOR_RESET" $symbol $price
        printf "$color%10.2f%12s$COLOR_RESET" $diff (printf "(%.2f%%)" $percent)
        printf " %s\n" "$nonRegularMarketSign"
    end
end