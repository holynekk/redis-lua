print("Hello Lua")

-- Comments like this

--[[
    or
    this
]]


a = "Redis"
b = Nil

print(a, b)

nothing = nil

bool1 = true
bool2 = false

num1, num2 = 134, 245

msg = "Test Message"

print(nil)

------------
n1 = 4
n2 = 0.4
n3 = 0.4e-3
n4 = 0.3e12
n5 = 5e+20

-- This is a string
html = [[
    <html>
        bla bla
    </html>
]] -- escaped

print(html)

-- Read stdin
-- line = io.read()
-- print(line)

x = "one string"
y = string.gsub(x, "one", "two")
print(x)
print(y)

print("2" + "5") -- calculates as number
print("2" > "15") -- calculates as strings

-- Logical operators ------------
-- and
-- or
-- not

-- Concat --------------

msg1 = "Test1"
msg2 = "Test2"
print(msg1 .. " " .. msg2)

print(1 .. 20) -- 120

-- Tables data type ---------------------


-- tbl1 = {}
-- tbl1[1] = 1
-- tbl1["key1"] = "value1"
-- tbl1.key2 = "value2"
-- print(tbl1["key"])
tbl_days = {"Mon", "Tue", "Wed"}
tbl_days[3] = "Fri"
print(tbl_days[3])

-- If else blocks

x = 10
if x > 12 then
    print("bum")
elseif x == 10 then
    print("ahahaha")
else
    print("in else")
end

y = x > 5 and print("x > 5")
print(y)

-- Loops

for num = 4, 10
do 
    print(num)
end


numbers = {20, 30, 40, 50}
sum, counter = 0, 1
while counter <= #numbers
do 
    sum = sum + numbers[counter]
    counter = counter + 1
end
print("Sum: ", sum)

