const package1 = require("../package1/index");

describe("packakge4", () => {
    it("should pass", () => {
        expect(1 + 1).toBe(2);
    });
    it("should work with package1", () => {
        package1();
        expect(1 + 1).toBe(2);
    });
});
