import { Then } from '@cucumber/cucumber';
import { ValidAccessibilityRoles } from '../../env/global';
import { ScenarioWorld } from '../setup/world'
import { waitFor } from '../../support/wait-for-behavior';


Then(
  /^I should see a "([^"]*)" with "([^"]*)" text$/,
  async function(this: ScenarioWorld, role: ValidAccessibilityRoles, name: string) {

    const {
      screen: { page },
    } = this;

    await waitFor(async() => {
      // NOTE: This locator uses html accessibility roles and names to find elements.
      // If your test is not finding an element, please verify that the role and name are correct.
      const locator = await page.getByRole(role, { name, exact: true });
      const isElementVisible = await locator.isVisible();
      return isElementVisible;
    })
  }
);