def ftoc(f_degrees)
  ((f_degrees - 32.0) * (5.to_f / 9.to_f))
end

def ctof(c_degrees)
  ((c_degrees * (9.to_f / 5.to_f)) + 32.0)
end