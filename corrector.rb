class Corrector
    def correct_name(name)
        cap = name.capitalize
        cap.length > 10 ? cap[0..9] : cap
    end
end