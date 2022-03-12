function join_channel!(command::Vector{SubString{String}}, storage, conn::IO)
    ip_addr = string(first(getpeername(conn)))
    name = command[2]

    response = DBInterface.execute(mysql_conn, """SELECT id, description, 
    name, protected, password, owner FROM channel WHERE name='$name'""")

    if (length(response) == 0)
        return (write(conn, "This channel doesnt exist\n"))
    end

    arr = first(response)
    if (arr.protected == 1)
        if (length(command) - 1 != 2)
            return (write(conn, "This channel required a password\n"))
        end
        if (Bcrypt.CompareHashAndPassword(arr.password, String(command[3])) == false)
            return (write(conn, "Invalid password\n"))
        end
    end

    storage.active_clients[ip_addr].current_channel_id = string(arr.id)
    if (channel_exist(storage, string(arr.id)) == false)
        storage.active_channels[string(arr.id)] = Data.Channel(string(arr.id), 
        arr.name, arr.description, arr.protected, arr.password, string(arr.owner))
    end
    write(conn, "Successfully joined\n")
end