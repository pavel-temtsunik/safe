require_relative "../lib/safe"

describe Safe do
  subject(:safe) { Safe.new }
  let(:random_code)     { rand 9999 }

  describe "#change_code" do
    context "then card is connected, and user input same code and code confirmation" do
       it  "allows to change the code" do
       safe.connect_card.change_code(random_code,random_code)
       expect(subject.code).to eq (random_code)
       end
    end


     context "then card is connected, and user input different code and code confirmation" do
          it "prohibits to change the code" do
            safe.connect_card.change_code(random_code,random_code+2)
            expect(subject.code).to_not eq (random_code)
          end
          end

     context "then card is not connected" do
          it "prohibits to change the code" do
            safe.change_code(random_code,random_code)
            expect(subject.code).to_not eq (random_code)
        end
        end

    end

    describe "#close_the_door" do
      context "if door is opened and user tries to close the door and input valid code" do
        it "allows to close the door" do
        safe.open_the_door(safe.code).close_the_door(safe.code)
        #expect(subject).to_not be opened   ---why it doesn't working??
        expect(subject.opened?).to eq(false)
        end
        end

       context "if door is opened and you close the door and input invalid code" do
         it "prohibits to close the door" do
           safe.open_the_door(safe.code).close_the_door(random_code)
           expect(subject.opened?).to eq(true)
         end
       end
      end

     describe "#open_the_door" do
       context "if door is closed and user input valid code" do
         it "allows to open the door" do
           safe.open_the_door(safe.code)
           expect(subject.opened?).to eq(true)
         end
       end

       context "if door is closed and user input invalid code" do
       it "prohibits to open the door" do
       safe.open_the_door(safe.code-1)
       expect(subject.opened?).to eq(false)
       end
       end

       context "if user have entered invalid code three times " do
         it "prohibits to open the door after 9 minutes wait" do
           3.times {safe.open_the_door(safe.code-1)}
           sleep 540
           safe.open_the_door(safe.code)
           expect(subject.opened?).to eq(false)
         end
         it "allows to open the door after 11 minutes wait do" do
          3.times {safe.open_the_door(safe.code-1)}
          sleep 660
          safe.open_the_door(safe.code)
          expect(subject.opened?).to eq(true)
       end
       end
     end
  end




