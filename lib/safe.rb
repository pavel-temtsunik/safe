require 'simplecov'
SimpleCov.start

class Safe

attr_accessor :opened , :code, :blocked, :card_connected, :attempts_left, :blocked_till

def initialize
  @opened=false
  @code=1111
  @blocked=false
  @card_connected=false
  @attempts_left=3
  @blocked_till=Time.now-1

end

def connect_card
  @card_connected=true
  self
end

def disconnect_card
  @card_connected=false
  self
end

def change_code (new_code, code_confirmation)
    if (new_code<1000 or new_code>9999) then
      p "New code must contain 4 digits"
      return
    end

    if card_is_connected? and new_code==code_confirmation then
     @code=new_code
     puts "New code   #{@code}"
   end
    puts "Connect the card" unless card_is_connected?
    puts "Invalid confirmation" unless new_code==code_confirmation
    self
end

def opened?
  res=true if @opened==true
  res=false if @opened==false
  res
end

def card_is_connected?
  res=true if @card_connected==true
  res=false if @card_connected==false
  res

end

def close_the_door(code)
  p "You try to close the door with invalid code" unless code==@code
  p " You try to close the door, but it is closed now" unless @opened==true
  if @opened==true and code==@code then
    @opened=false
    p "door was closed"
  end

end

  def open_the_door(code)
    if Time.now < @blocked_till then
      puts p "You entered invalid code 3 times, please wait for #{(@blocked_till-Time.now)/60} minutes and try again"
      return
    end
      p "You try to open the door with invalid code, you have #{@attempts_left} attempts"  unless code==@code
      p " You try to open the door, but it is opened now" unless @opened==false

    if code!=@code and Time.now > @blocked_till  then
      @attempts_left-=1
      if @attempts_left==0 then
        @blocked_till=Time.now+600
        @attempts_left=3
      end
    end

    if Time.now <@blocked_till then
      p "You entered invalid code 3 times, please wait for #{(@blocked_till-Time.now)/60} minutes and try again"
      return
    end

   if Time.now > @blocked_till then
        if @opened==false and code==@code then
          @opened=true
          p "the door was opened"
        end
   end
self
end

end

