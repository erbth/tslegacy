exception Gp_exception of string
exception Invalid_filename

(* package name, packed filename, major, minor, revision *)
type fv = (string * string * int * int * int)

let fv_of_packed_name (pn : string) : fv =
    try
        let vstart =
            String.rindex pn '-' + 1
        in
        let vstop =
            String.rindex pn '_'
        in
        match vstart > 1 && vstart < vstop with
            | false -> raise Invalid_filename
            | true ->
        let vstring =
            String.sub pn vstart (vstop - vstart)
        in
        let pkg_name =
            String.sub pn 0 (vstart - 1)
        in
        let first_dot =
            String.index vstring '.'
        in
        let last_dot =
            String.rindex vstring '.'
        in
        match
            first_dot > 0 &&
            last_dot > (first_dot + 1) &&
            last_dot < (String.length vstring - 1)
        with
            | false -> raise Invalid_filename
            | true ->
        let major =
            String.sub vstring 0 first_dot
            |> int_of_string
        in
        let minor =
            String.sub vstring (first_dot + 1) (last_dot - first_dot - 1)
            |> int_of_string
        in
        let revision =
            String.sub
                vstring
                (last_dot + 1)
                (String.length vstring - last_dot - 1)
            |> int_of_string
        in
        (pkg_name, pn, major, minor, revision)
    with
        | Invalid_filename
        | Not_found
        | Failure _ ->
            raise (Gp_exception ("Invalid packed filename: \"" ^ pn ^ "\""))

let string_of_version ((major : int), (minor : int), (revision : int)) =
    string_of_int major ^ "." ^
    string_of_int minor ^ "." ^
    string_of_int revision

let version_newer
    ((maj1 : int), (min1 : int), (rev1 : int))
    ((maj2 : int), (min2 : int), (rev2 : int)) =

    (maj1 > maj2) ||
    (maj1 = maj2 && min1 > min2) ||
    (maj1 = maj2 && min1 = min2 && rev1 > rev2)

let remove_file (dirname : string) (pathname : string) =
    let pathname =
        dirname ^ "/" ^ pathname
    in
    print_endline ("Removing file \"" ^ pathname ^ "\"");
    Sys.remove pathname

let rm_old_pkgs (dir : string) =
    let htable =
        Hashtbl.create ~random:true 100
    in
    let process_fv
        (dir : string)
        (pkg_name, filename, major, minor, revision) =

        let fmmr =
            (filename, major, minor, revision)
        in
        print_endline ("Processing \"" ^ pkg_name ^ "\"=" ^
                    string_of_version (major, minor, revision));
        match Hashtbl.find_opt htable pkg_name with
            | None ->
                Hashtbl.add htable pkg_name fmmr
            | Some (old_filename, old_major, old_minor, old_revision) ->
                match
                    version_newer
                        (major, minor, revision)
                        (old_major, old_minor, old_revision)
                with
                    | false -> remove_file dir filename
                    | true ->
                        remove_file dir old_filename;
                        Hashtbl.replace
                            htable
                            pkg_name
                            (filename, major, minor, revision)
    in
    try
        let fvs =
            Sys.readdir dir
            |> Array.to_list
            |> List.map
                fv_of_packed_name
        in
        List.iter
            (process_fv dir)
            fvs;
        exit 0
    with
        | Gp_exception msg
        | Sys_error msg -> print_endline msg; false

let () =
    match Array.length Sys.argv with
        | 2 -> if rm_old_pkgs Sys.argv.(1) then exit 0 else exit 1
        | _ -> print_endline ("Usage: " ^ Sys.argv.(0)); exit 1