import { render, screen } from '@testing-library/react';
import App from './App';

test('renders task manager', () => {
  render(<App />);
  const linkElement = screen.getByText(/Task Manager/i);
  expect(linkElement).toBeInTheDocument();
});