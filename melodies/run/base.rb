def mybpm()
  return 60
end

def mysynth()
  return :piano
end

def melody()
  
  m = []
  t = []

  m1 = []
  t1 = []
  [64, 60, 62, 59].each do |x|
    m1.concat([x])
    t1.concat([2*F])
  end
  
  m.concat(m1 + m1)
  t.concat(t1 + t1)

  m2 = [64, 66]
  t2 = rep(2*F, 2)

  m.concat(m2 + m2)
  t.concat(t2 + t2)

  m3 = []
  t3 = []
  m3.concat(repa([67, 71], 4))
  m3.concat(repa([69, 72], 4))
  t3 = rep(Q, 16)

  m.concat(m3 + m3)
  t.concat(t3 + t3)

  m.concat(m1)
  t.concat(t1)

  return m, t
end
