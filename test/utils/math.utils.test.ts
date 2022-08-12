import { dif, sum } from "../../src/utils/math.utils";

describe("testing math module", () => {
  test("dif", () => {
    expect(dif(2, 1)).toBe(1);
  });
  test("sum", () => {
    expect(sum(2, 1)).toBe(3);
  });
});
