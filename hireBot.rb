# Osbaldo Esquivel
# 10-19-2017

def define(stages,args,decHash)
    temp_arr = args
    temp_arr.delete("DEFINE")
    $last_stage = temp_arr.last
    list = args.join(" ")
    count = temp_arr.length
    count.times do |c|
        stages.push(temp_arr[c])
        decHash[temp_arr[c]] = 0
    end
    output_file = File.new("output.txt", "w")
    output_file.puts("DEFINE #{list}")
    output_file.close
end

def create(emails,email)
    if emails.include? (email)
        output_file = File.open("output.txt","a")
        output_file.puts("Duplicate applicant")
        output_file.close
    else
        emails.push(email)
        output_file = File.open("output.txt","a")
        output_file.puts("CREATE #{email}")
        output_file.close
    end
end

def advance(advHash,line,emails,stages,decs)
    count = emails.length
    count.times do |c|
        advHash[emails[c]] = stages[0]
    end
    name_loc = emails.find_index("#{line[1]}")
    adv_stage = line[2]
    if adv_stage != nil
        curr_stage = advHash[emails[name_loc]]
        if curr_stage == adv_stage
            output_file = File.open("output.txt","a")
            output_file.puts("Already in #{adv_stage}")
            output_file.close
        else
            idx = stages.find_index(curr_stage)
            advHash[emails[name_loc]] = stages[idx+1] 
            if advHash[emails[name_loc]] == $last_stage
                output_file = File.open("output.txt","a")
                output_file.puts("Already in #{$last_stage}")
                output_file.close
                decs[$last_stage] += 1
            else
                output_file = File.open("output.txt","a")
                output_file.puts("ADVANCE #{line[1]}")
                output_file.close
                decs[advHash[emails[name_loc]]] += 1
            end
        end
    else
        curr_stage = advHash[emails[name_loc]]
        idx = stages.find_index(curr_stage)
        if curr_stage == $last_stage
            output_file = File.open("output.txt","a")
            output_file.puts("Already in #{adv_stage}")
            output_file.close
            decs[$last_stage] += 1
        else
            advHash[emails[name_loc]] = stages[idx+1]
            output_file = File.open("output.txt","a")
            output_file.puts("ADVANCE #{line[1]}")
            output_file.close
            decs[advHash[emails[name_loc]]] += 1
        end
    end
end

def decide(advHash,line,emails,stages,stageDec)
    dec = line[2]
    name_loc = emails.find_index("#{line[1]}")
    if dec.to_i == 0
        output_file = File.open("output.txt","a")
        output_file.puts("Rejected #{line[1]}")
        output_file.close
        $rejected +=1
        stageDec[advHash[emails[name_loc]]] = 0
    else
        if advHash[emails[name_loc]] == $last_stage
            output_file = File.open("output.txt","a")
            output_file.puts("Hired #{line[1]}")
            output_file.close
            stageDec[advHash[emails[name_loc]]] = dec.to_i
            $hired +=1
        else
            output_file = File.open("output.txt","a")
            output_file.puts("Failed to decide for #{line[1]}")
            output_file.close
        end
    end
end

def stats(decs,stages)
    len = decs.length
    temp_arr = []
    len.times do |l|
        temp_stage = stages[l]
        stage_hire = decs[stages[l]]
        temp_arr.push(temp_stage)
        temp_arr.push(stage_hire)
    end
    temp_arr.push("Hired")
    temp_arr.push($hired)
    temp_arr.push("Rejected")
    temp_arr.push($rejected)
    output_file = File.open("output.txt","a")
    output_file.puts(temp_arr.join(" "))
    output_file.close
end

file_name = ARGV[0]
$last_stage = ""
$hired = 0
$rejected = 0
emails = []
stage_list = []
advHash = {}
stageDec = {}
contents = File.open(file_name).read
contents.each_line do |line|
    line_comms = line.split(" ")
    case line_comms[0]
        when "DEFINE" then define(stage_list,line_comms,stageDec)
        when "CREATE" then create(emails,line_comms[1])
        when "ADVANCE" then advance(advHash,line_comms,emails,stage_list,stageDec)
        when "DECIDE" then decide(advHash,line_comms,emails,stage_list,stageDec)
        when "STATS" then stats(stageDec,stage_list)
    end
end






